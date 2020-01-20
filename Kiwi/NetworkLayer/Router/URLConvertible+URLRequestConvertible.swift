//
//  URLConvertible+URLRequestConvertible.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation


// MARK: - URLConvertible
/// Types adopting the `URLConvertible` protocol can be used to safely construct `URL`s.
public protocol URLConvertible {
    /// Returns a `URL` from the conforming instance or throws.
    ///
    /// - Returns: The `URL` created from the instance.
    /// - Throws:  Any error thrown while creating the `URL`.
    func asURL() throws -> URL
}

extension String: URLConvertible {
    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
    ///
    /// - Returns: The `URL` initialized with `self`.
    /// - Throws:  An `AFError.invalidURL` instance.
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw HTTPError.invalidURL(url: self) }

        return url
    }
}

extension URL: URLConvertible {
    /// Returns `self`.
    public func asURL() throws -> URL { return self }
}




// MARK: -  URLRequestConvertible
/// Types adopting the `URLRequestConvertible` protocol can be used to safely construct `URLRequest`s.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    /// The `URLRequest` returned by discarding any `Error` encountered.
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    /// Returns `self`.
    public func asURLRequest() throws -> URLRequest { return self }
}
