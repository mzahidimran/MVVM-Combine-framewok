//
//  URLRouter.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation


// MARK: - URLRouter
/// `URLRouter` responsible to create `URL`s for HTTP requests
class URLRouter {
    
    /// `URLRouter` init is not allowed use `static` method `environment(_ environment:)` to create `URL`
    private init() {}
    private var url: URL?
    
    
    /// `Router` init is not allowed use `static` method `request(_ urlComponents:)` to create request
    static func environment(_ environment: Environment) -> URLRouter {
        let router = URLRouter()
        router.url = try? environment.rawValue.asURL()
        return router
    }
    
    
    /// Generates filghts API `URlL`
    /// - Parameter id: `Optional` id to be used to append in `URL`
    func flights(id: String? = nil) -> URLRouter {
        self.url = url?.appendingPathComponent("flights")
        if let id = id {
            self.url = url?.appendingPathComponent(id)
        }
        return self
    }
}

extension URLRouter: URLConvertible {
    
    func asURL() throws -> URL {
        guard let url = url else { throw HTTPError.invalidURL(url: "Invalid URL") }
        return url
    }
}
