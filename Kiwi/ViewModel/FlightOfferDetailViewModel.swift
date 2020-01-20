//
//  FlightOfferDetailViewModel.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import  Combine

class FlightOfferDetailViewModel {
    
    private var flight:Flight
    
    @Published private(set) var destination: String?
    @Published private(set) var price: String?
    @Published private(set) var date:String?
    @Published private(set) var duration: String?
    @Published private(set) var bannerURL:URL?
    
    private var currencyFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter
    }()
    
    init(flight: Flight) {
        self.flight = flight
        self.destination = flight.cityTo ?? ""
        self.price = currencyFormatter.string(from: NSNumber(value: flight.conversion?.eUR ?? (flight.price ?? 0) )) ?? "Price N/A"
        self.date = DateHelperFormat.string(from: flight.dTimeUTC, format: "dd MMM, YYYY H:mm")
        
        if let duration = flight.duration?.total {
            self.duration = "\(duration / 3600)hrs, \((duration % 3600) / 60) min"
        }
        else {
            self.duration = nil
        }
        
        self.bannerURL = flight.toCityBannerURL
        
    }
    
    
    
}
