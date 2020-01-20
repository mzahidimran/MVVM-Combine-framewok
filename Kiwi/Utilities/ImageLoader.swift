//
//  ImageLoader.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit
import Combine

fileprivate let imageCache = NSCache<NSString, UIImage>()

// MARK: - ImageLoader
/// Helper singleton class to load `UIImage` from cache if doesn't exist load from `URL`
class ImageLoader {
    
    /// Shared object
    static let shared = ImageLoader()
    
    
    /// `init` is marked private to top initializations for `class`
    private init() {}
    
    private var disposalBag = DisposeBag()
    
    private var repository: Repository = RemoteRepository()
    
    
    
    /// Create `AnyPublisher` to load image from `NSCache` OR `URL`
    /// - Parameter url: `URL` to load image from
    /// - returns: `AnyPublisher` of output  `UIImage` and `HTTPError`
    func loadImage(url: URLConvertible) throws -> AnyPublisher<UIImage, HTTPError> {
        
        let url = try url.asURL()
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            let just = Just<UIImage>(cacheImage)
            return just.setFailureType(to: HTTPError.self).eraseToAnyPublisher()
        }
        else {
            return try repository.loadImage(request: Router.request(url))
                .handleEvents(receiveOutput: { image in
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                })
                .eraseToAnyPublisher()
        }

        
    }
    
}
