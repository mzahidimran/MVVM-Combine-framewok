//
//  Date+Formatter.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation

// MARK: - DateHelperFormat
/// `DateFormatter` helper `struct` to convert date to specified format string
struct DateHelperFormat {
    
    static let dateFormatter = DateFormatter()
    
    /// `init` is marked private to top initializations for `struct`
    private init() {}
    
    /// Convert date to string with respect to format
    /// - Parameters:
    ///   - date: date to convert to string
    ///   - format: format of date string
    /// - returns: date string according to format  
    static func string(from date: Date, format:String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
 
    
}
