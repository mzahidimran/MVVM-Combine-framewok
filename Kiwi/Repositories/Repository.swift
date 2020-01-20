//
//  Repository.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/19/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol Repository {
    func searchFlights(params: [String : Any]) throws -> AnyPublisher<FlightOfferResponse, HTTPError>
    func loadImage(request: URLRequestConvertible) throws -> AnyPublisher<UIImage, HTTPError>
}
