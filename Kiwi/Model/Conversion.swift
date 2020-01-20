//
//  Conversion.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
struct Conversion : Codable {
	let eUR : Int?

	enum CodingKeys: String, CodingKey {

		case eUR = "EUR"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		eUR = try values.decodeIfPresent(Int.self, forKey: .eUR)
	}

}
