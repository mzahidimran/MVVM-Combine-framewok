//
//  UIControlPublisher.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import Combine
import UIKit

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
struct UIControlPublisher<Control: UIControl>: Publisher {

    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    
    /// `init` method for publisher
    /// - Parameters:
    ///   - control: `UIControl`  for publishing
    ///   - events: `UIControl.Event` to publish
    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    
    /// `Publisher` protocol method to attach `Subscriber` to this `Publisher` by `subscribe(_:)`
    /// - Parameter subscriber: subscriber to attach
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}
