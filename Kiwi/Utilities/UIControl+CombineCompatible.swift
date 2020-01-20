//
//  UIControl+CombineCompatible.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit


/// Protocol to make `UIControl` to be compatible with `Combine` framework
protocol CombineCompatible { }

extension UIControl: CombineCompatible { }

// MARK: - CombineCompatible
/// `CombineCompatible` extension for `UIControl`
extension CombineCompatible where Self: UIControl {
    
    /// Factory method to create publishers for `UIControl.Event`s
    /// - Parameter events: publisher event
    /// - returns: `UIControlPublisher` of type `self`
    func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}
