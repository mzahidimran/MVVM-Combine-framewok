//
//  UIStoryboard+Helper.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/21/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit

/// Storyboard enum makes easy to initiate view controllers
enum Storyboard: String {
    case main = "Main"
    
    /// instantiate view controller with identifier
    /// - Parameter identifier: `Optional` identifier for custom Ids OR class name would be used as `indentifier`
    func instantiateViewController<T: UIViewController>(identifier: String = String(describing: T.self)) -> T? {
        return UIStoryboard(name: self.rawValue, bundle: Bundle(for: T.self)).instantiateViewController(identifier: identifier) as? T
    }
    
    
    /// instantiate initial view controller of storyboard
    func instantiateInitialViewController<T: UIViewController>() -> T? {
        return UIStoryboard(name: self.rawValue, bundle: Bundle(for: T.self)).instantiateInitialViewController() as? T
    }
}
