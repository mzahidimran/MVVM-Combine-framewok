//
//  UIControlSubscription.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit
import Combine

/// A custom subscription to capture UIControl target events.
final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control
    
    /// `init` method for `UIControlSubscription`
    /// - Parameters:
    ///   - subscriber: subscriber of type `Subscriber` which takes input `UIControl`
    ///   - control: `UIControl` for subscription
    ///   - event: event to subscribe `UIControl.Event`
    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }
    
    
    /// cancel  subscription
    func cancel() {
        subscriber = nil
    }

    
    /// handle events from `UIControl`
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}
