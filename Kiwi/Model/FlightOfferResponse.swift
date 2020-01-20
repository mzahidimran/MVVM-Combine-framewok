//
//  FlightOfferResponse.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
struct FlightOfferResponse : Codable {
	let search_id : String?
	let data : [Flight]?
	let connections : [String]?
	let time : Int?
	let currency : String?
	let currency_rate : Double?
	let fx_rate : Double?
	let refresh : [String]?
	let del : Double?
	let ref_tasks : [String]?
	let all_stopover_airports : [String]?
	let all_airlines : [String]?

}
