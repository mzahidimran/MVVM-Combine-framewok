//
//  Agent.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import Combine
import UIKit

// MARK: - RemoteRepository
/// `RemoteRepository`  confirms to `Repository` to act as repository for app
class RemoteRepository {
    
    private let session: URLSession
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.secondsSince1970
        return decoder
    }()
    
    /// `init`
    /// - Parameter session: session for network requests
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    /// Run a JSON request and validates `session` response n `decoding`  errors
    /// - Parameters:
    ///   - request: `URLRequestConvertible` to load json
    ///   - decoder: `JSONDecoder` to decode response from request
    /// - returns: `AnyPublisher` of  generic `Decodable` with `HTTPError`
    private func run<T: Decodable>(_ request: URLRequestConvertible, _ decoder: JSONDecoder = JSONDecoder()) throws -> AnyPublisher<T, HTTPError> {
        return try session
            .dataTaskPublisher(for: request.asURLRequest())
            .mapError({ (error) -> HTTPError in
                return .sessionError(description: error.localizedDescription)
            })
            .tryMap { output in
                
                try RemoteRepository.validate(output.response)
                
                let value = try decoder.decode(T.self, from: output.data)
                return value
            }

            .catch { (error) -> AnyPublisher<T, HTTPError>  in // catch encoding errors and response validation errors
                if let errorHTTP = error as? HTTPError {
                    return Fail(error: errorHTTP).eraseToAnyPublisher()
                }
                else {
                    return Fail(error: HTTPError.encodingIssue(description: error.localizedDescription)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    /// Run a data request  and validates `session` responses
    /// - Parameters:
    ///   - request: `URLRequestConvertible` to load json
    /// - throws: HTTPError
    /// - returns: `AnyPublisher` of   `UIImage` with `HTTPError`
    private func runData(_ request: URLRequestConvertible) throws -> AnyPublisher<UIImage, HTTPError> {
        try session
            .dataTaskPublisher(for: request.asURLRequest())
            .mapError({ (error) -> HTTPError in
                return .sessionError(description: error.localizedDescription)
            })
            .tryMap { (output) -> UIImage in
                
                try RemoteRepository.validate(output.response)
                
                guard let image = UIImage(data: output.data) else {
                    throw HTTPError.invalidResponse
                }
                return image
            }
            .catch { (error) -> AnyPublisher<UIImage, HTTPError>  in
                if let errorHTTP = error as? HTTPError {
                    return Fail(error: errorHTTP).eraseToAnyPublisher()
                }
                else {
                    return Fail(error: HTTPError.encodingIssue(description: error.localizedDescription)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    /// Validate `URLResponse` for response codes and `session` errors
    /// - Parameter response: response to validate
    /// - throws: HTTPError
    fileprivate static func validate(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else{
            throw HTTPError.invalidResponse
        }
        guard (200..<300).contains(response.statusCode) else {
            throw HTTPError.unacceptableStatusCode(code: response.statusCode, apiError: nil)
        }
    }
    
}


extension RemoteRepository: Repository {
    
    func loadImage(request: URLRequestConvertible) throws -> AnyPublisher<UIImage, HTTPError> {
        return try runData(request)
    }
    
    func searchFlights(params: [String : Any]) throws -> AnyPublisher<FlightOfferResponse, HTTPError>  {
        let request = Router.request(URLRouter.environment(.dev).flights()).method(.get).parameters(params)
        return try run(request, jsonDecoder)
    }
}
