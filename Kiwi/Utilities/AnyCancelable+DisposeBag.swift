//
//  AnyCancelable+DisposeBag.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/19/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import Combine

typealias DisposeBag = [AnyCancellable]

// MARK: - AnyCancellable+DisposeBag
/// Adds dispose functionality to `AnyCancellable` class can be can be used to store subscriber tokens.
extension AnyCancellable {
    
    /// Add `AnyCancellable` to dispose bag
    /// - Parameter bag: `inout` bag for disposal
    func add(to bag:inout DisposeBag) -> Void {
        bag.append(self)
    }
    
}
