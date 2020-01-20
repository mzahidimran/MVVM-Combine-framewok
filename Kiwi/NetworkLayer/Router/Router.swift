//
//  Router.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation

// MARK: - Router
/// `Router` is responsible for creating requests using  chaining`func`s to make urls more readable
class Router {
    
    /// `Router` init is not allowed use `static` method `request(_ urlComponents:)` to create request
    private init() {}
    
    private var url: URL?
    private var method = HTTPMethods.get
    private var params:[String: Any] = [:]
    
    enum HTTPMethods: String { // http methods
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /// Generates basic request with `URL`
    /// - Parameter urlComponents: `URLConvertible` fo get  `URL`
    static func request(_ urlComponents: URLConvertible) -> Router {
        let remote = Router()
        remote.url = try? urlComponents.asURL()
        return remote
    }
    
    
    /// Update `URLRequest` method
    /// - Parameter method: method to be used for `URLRequest`
    func method(_ method:HTTPMethods) -> Router {
        self.method = method
        return self
    }
    
    
    /// Add parameters to `URLRequest`
    /// - Parameter params: parameters  to be used for `URLRequest`
    func parameters(_ params:[String: Any]) -> Router {
        self.params = params
        return self
    }
    
}

extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        guard let url = url else { throw HTTPError.invalidURL(url: "Invalid URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        if self.method == .get {
            let query = params.compactMap ({ URLQueryItem(name: "\($0)", value: "\($1)") }) 
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = query
            urlRequest.url = urlComponents.url
            
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return urlRequest
    }
    
}
