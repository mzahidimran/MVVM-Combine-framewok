//
//  CountryFrom.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
struct CountryFrom : Codable {
	let code : String?
	let name : String?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
