//
//  Flight.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
struct Flight : Codable {
	let id : String?
	let baglimit : Baglimit?
	let p1 : Int?
	let p2 : Int?
	let p3 : Int?
	let price : Int?
	let route : [Route]?
	let airlines : [String]?
	let pnr_count : Int?
	let transfers : [String]?
	let has_airport_change : Bool?
	let technical_stops : Int?
	let type_flights : [String]?
	let dTime : Date?
	let dTimeUTC : Date
	let aTime : Date?
	let aTimeUTC : Date?
	let nightsInDest : String?
	let flyFrom : String?
	let flyTo : String?
	let cityFrom : String?
	let cityTo : String?
	let cityCodeFrom : String?
	let cityCodeTo : String?
	let countryFrom : CountryFrom?
	let countryTo : CountryTo?
	let mapIdfrom : String?
	let mapIdto : String?
	let distance : Double?
	let routes : [[String]]?
	let virtual_interlining : Bool?
	let fly_duration : String?
	let duration : Duration?
	let facilitated_booking_available : Bool?
	let found_on : [String]?
	let conversion : Conversion?
	let popularity : Double?
	let quality : Double?
	let booking_token : String?
	let deep_link : String?
    
    var toCityBannerURL:URL? {
        guard let id = mapIdto else { return nil }
        return URL(string: "https://images.kiwi.com/photos/600x600/\(id).jpg")
    }
}
