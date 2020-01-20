//
//  FlighOfferViewModel.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/19/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import Combine

fileprivate let defaultError = "Unable to load flights at the moment"

class FlighOfferViewModel {
    
    private var repository: Repository
    
    private var token: AnyCancellable?
    {
        didSet {
            self.isLoading = token != nil
        }
    }
    
    private var flights: [Flight]? {
        didSet {
            flightOfferCount = flights?.count ?? 0
        }
    }
    
    @Published var flightOfferCount:Int = 0
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    init(repository: Repository = RemoteRepository()) {
        self.repository = repository
    }
    
    
    func flight(at index:Int) -> FlightOfferDetailViewModel? {
        guard let flights = flights else { return nil }
        if !(0..<flights.count).contains(index) { return nil }
        return FlightOfferDetailViewModel(flight: flights[index])
    }
    
    func loadFlights(date:Date = Date()) -> Void {
        
        let params:[String: Any] = ["v":2,
                                    "sort":"popularity",
                                    "asc":0,
                                    "dateFrom": DateHelperFormat.string(from: date, format: "dd/MM/yyyy"),

                                    "locale":"en",
                                    "fly_from":"PRG",
                                    "partner":"picky",
                                    "limit":45,
                                    "to":"anywhere",
                                    "featureName":"aggregateResults",
                                    "typeFlight":"oneway",
                                    "one_per_date":0,
                                    "oneforcity":1]
        do {
            token = try repository.searchFlights(params: params)
                .map({ (response) -> [Flight] in
                    return (response.data ?? [])
                })
            .sink(receiveCompletion: {[unowned self] (result) in
                self.token = nil
                switch (result) {
                case .finished:
                    break
                case .failure(let error):
                    self.handleError(error: error)
                }
            }, receiveValue: {[unowned self] (response) in
                self.flights = response.sorted { (first, second) -> Bool in
                    return first.dTimeUTC < second.dTimeUTC
                }
            })
        }
        catch {
            self.error = defaultError
        }
    }
    
    private func handleError(error: HTTPError) {
        switch error {
        case .invalidResponse, .encodingIssue, .invalidURL:
            self.error = defaultError
        case .unacceptableStatusCode( _, let apiError):
            self.error = apiError?.message?.first?.errors?.joined(separator: "\n") ?? defaultError
        case .sessionError(let description):
            self.error = description
        }
    }
    
}
