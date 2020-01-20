//
//  KWError.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation


/// HTTPError for network requests
enum HTTPError: Error {
    case invalidURL(url: String)
    case invalidResponse
    case unacceptableStatusCode(code: Int, apiError: APIError?)
    case sessionError(description: String)
    case encodingIssue(description: String)
}
