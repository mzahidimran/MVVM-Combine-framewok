//
//  Route.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//


import Foundation
struct Route : Codable {
    
	let fare_basis : String?
	let fare_category : String?
	let fare_classes : String?
	let price : Int?
	let fare_family : String?
	let found_on : String?
	let last_seen : Int?
	let refresh_timestamp : Int?
	let source : String?
	let bags_recheck_required : Bool?
	let guarantee : Bool?
	let id : String?
	let combination_id : String?
	let original_return : Int?
	let aTime : Int?
	let dTime : Int?
	let aTimeUTC : Int?
	let dTimeUTC : Int?
	let mapIdfrom : String?
	let mapIdto : String?
	let cityTo : String?
	let cityFrom : String?
	let cityCodeFrom : String?
	let cityCodeTo : String?
	let flyTo : String?
	let flyFrom : String?
	let airline : String?
	let operating_carrier : String?
	let equipment : String?
	let latFrom : Double?
	let lngFrom : Double?
	let latTo : Double?
	let lngTo : Double?
	let flight_no : Int?
	let vehicle_type : String?
	let operating_flight_no : String?


}
