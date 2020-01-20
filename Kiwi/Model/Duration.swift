//
//  Duration.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
struct Duration : Codable {
	let departure : Int?
	let returnDuration : Int?
	let total : Int?

	enum CodingKeys: String, CodingKey {

		case departure = "departure"
		case returnDuration = "return"
		case total = "total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		departure = try values.decodeIfPresent(Int.self, forKey: .departure)
		returnDuration = try values.decodeIfPresent(Int.self, forKey: .returnDuration)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}

}
