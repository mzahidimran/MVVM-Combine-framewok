//
//  UIImageView+Cache.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit
import Combine

private var AssociatedObjectHandle: UInt8 = 0

// MARK: - UIImageView+Cache
/// Extends `UIImageView` with image loading from `URL` and caching
extension UIImageView {
    
    private var dispose: AnyCancellable? {
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? AnyCancellable
        }
    }
    
    /// Load and set image from `URL`
    /// - Parameter url: `URL` to load image
    func loadImage(url: URL) {
        self.dispose = try? ImageLoader.shared.loadImage(url: url)
            .replaceError(with: UIImage(named: "photos")!)
            .sink(receiveValue: { image in self.image = image})
    }
}
