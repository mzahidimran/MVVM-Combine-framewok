//
//  Mocks.swift
//  KiwiTests
//
//  Created by Muhammad Zahid Imran on 1/21/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation

class Mocks {

    let invalidResponse = URLResponse(url: URL(string: base)!,
                                      mimeType: nil,
                                      expectedContentLength: 0,
                                      textEncodingName: nil)
    
    let validResponse = HTTPURLResponse(url: URL(string: base)!,
                                        statusCode: 200,
                                        httpVersion: nil,
                                        headerFields: nil)
    
    let invalidResponse300 = HTTPURLResponse(url: URL(string: base)!,
                                           statusCode: 300,
                                           httpVersion: nil,
                                           headerFields: nil)
    let invalidResponse401 = HTTPURLResponse(url: URL(string: base)!,
                                             statusCode: 401,
                                             httpVersion: nil,
                                             headerFields: nil)
    
    let networkError = NSError(domain: "NSURLErrorDomain",
                               code: -1004, //kCFURLErrorCannotConnectToHost
                               userInfo: nil)
    
    let popularFlightsResponse = """
            {
              "search_id" : "94c380b3-3d16-47a0-acb5-7bc98928dcd2",
              "data" : [
                {
                  "id" : "145c0b77477400002a5f84b1_0",
                  "bags_price" : {
                    "1" : 33.54,
                    "2" : 67.09
                  },
                  "baglimit" : {
                    "hand_width" : 40,
                    "hand_height" : 55,
                    "hand_length" : 20,
                    "hand_weight" : 10,
                    "hold_width" : 119,
                    "hold_height" : 119,
                    "hold_length" : 81,
                    "hold_dimensions_sum" : 319,
                    "hold_weight" : 20
                  },
                  "p1" : 1,
                  "p2" : 1,
                  "p3" : 1,
                  "price" : 12,
                  "route" : [
                    {
                      "fare_basis" : "",
                      "fare_category" : "M",
                      "fare_classes" : "",
                      "price" : 1,
                      "fare_family" : "",
                      "found_on" : "deprecated",
                      "last_seen" : 1579368065,
                      "refresh_timestamp" : 1579368065,
                      "source" : "deprecated",
                      "return" : 0,
                      "bags_recheck_required" : false,
                      "guarantee" : false,
                      "id" : "145c0b77477400002a5f84b1_0",
                      "combination_id" : "145c0b77477400002a5f84b1",
                      "original_return" : 0,
                      "aTime" : 1580463900,
                      "dTime" : 1580459700,
                      "aTimeUTC" : 1580460300,
                      "dTimeUTC" : 1580456100,
                      "mapIdfrom" : "prague_cz",
                      "mapIdto" : "budapest_hu",
                      "cityTo" : "Budapest",
                      "cityFrom" : "Prague",
                      "cityCodeFrom" : "PRG",
                      "cityCodeTo" : "BUD",
                      "flyTo" : "BUD",
                      "flyFrom" : "PRG",
                      "airline" : "FR",
                      "operating_carrier" : "",
                      "equipment" : null,
                      "latFrom" : 50.1008333,
                      "lngFrom" : 14.26,
                      "latTo" : 47.4369444,
                      "lngTo" : 19.2555556,
                      "flight_no" : 4050,
                      "vehicle_type" : "aircraft",
                      "operating_flight_no" : ""
                    }
                  ],
                  "airlines" : [
                    "FR"
                  ],
                  "pnr_count" : 1,
                  "transfers" : [],
                  "has_airport_change" : false,
                  "technical_stops" : 0,
                  "availability" : {
                    "seats" : null
                  },
                  "type_flights" : [
                    "deprecated"
                  ],
                  "dTime" : 1580459700,
                  "dTimeUTC" : 1580456100,
                  "aTime" : 1580463900,
                  "aTimeUTC" : 1580460300,
                  "nightsInDest" : null,
                  "flyFrom" : "PRG",
                  "flyTo" : "BUD",
                  "cityFrom" : "Prague",
                  "cityTo" : "Budapest",
                  "cityCodeFrom" : "PRG",
                  "cityCodeTo" : "BUD",
                  "countryFrom" : {
                    "code" : "CZ",
                    "name" : "Czechia"
                  },
                  "countryTo" : {
                    "code" : "HU",
                    "name" : "Hungary"
                  },
                  "mapIdfrom" : "prague_cz",
                  "mapIdto" : "budapest_hu",
                  "distance" : 471.28,
                  "routes" : [
                    [
                      "PRG",
                      "BUD"
                    ]
                  ],
                  "virtual_interlining" : false,
                  "fly_duration" : "1h 10m",
                  "duration" : {
                    "departure" : 4200,
                    "return" : 0,
                    "total" : 4200
                  },
                  "facilitated_booking_available" : false,
                  "found_on" : [
                    "deprecated"
                  ],
                  "conversion" : {
                    "EUR" : 12
                  },
                  "popularity" : 3921749,
                  "quality" : 33.33328,
                  "booking_token" : "AlNnD7Vixv1HavGn_URfNmBOaE_hoJ3PmeCEzwgsEtu9yE1ooFe9u-ttQLBZmnRUHd2SJQmwS-dNACZPspXWke7_unJIQUw97i-9OrN9DHUbmcQnWieLS2KdaZmMp7hkpKWi3vRpucri61BHbm4OI2kItGcZNRMhbg_3-Cz3Ts0O5a4jkYB8e76ZZA27Olg35kIUFMCDiGhV7pKO28FmoDldHAka35sEvXghrp7V706QBqr94cjszF9MjV4bAHOhmyFLcvo5pYkeOXSDBUG5QitmZQVv-VMZ9bUm8z7JPASBgiWUiJ0GU6tvDhWCniFZunrJjPWFb0ta-SCbeviL3kjoC1xwK38okcB0u0EX0NffhQu85As-JaSW5E8ngIRc_FCK-pE2TijhfWiRlYmoXUOPi2pfLKr3gOCIS6zOqJn20OCS_dMGvdzBDmAwjPL5yBviFvRD5mJexyX8crsmE3eOpC2s59eP6pWDo1NOCj5VXiekuRl2zd3MTSRoJ2iECaKoDD1o10BpYfI5isjqLKBvjVwUpvULlupq3vFC12-w=",
                  "deep_link" : "https://www.kiwi.com/deep?from=PRG&to=BUD&departure=31-01-2020&flightsId=145c0b77477400002a5f84b1_0&price=12&passengers=1&affilid=picky&lang=en&currency=EUR&booking_token=AlNnD7Vixv1HavGn_URfNmBOaE_hoJ3PmeCEzwgsEtu9yE1ooFe9u-ttQLBZmnRUHd2SJQmwS-dNACZPspXWke7_unJIQUw97i-9OrN9DHUbmcQnWieLS2KdaZmMp7hkpKWi3vRpucri61BHbm4OI2kItGcZNRMhbg_3-Cz3Ts0O5a4jkYB8e76ZZA27Olg35kIUFMCDiGhV7pKO28FmoDldHAka35sEvXghrp7V706QBqr94cjszF9MjV4bAHOhmyFLcvo5pYkeOXSDBUG5QitmZQVv-VMZ9bUm8z7JPASBgiWUiJ0GU6tvDhWCniFZunrJjPWFb0ta-SCbeviL3kjoC1xwK38okcB0u0EX0NffhQu85As-JaSW5E8ngIRc_FCK-pE2TijhfWiRlYmoXUOPi2pfLKr3gOCIS6zOqJn20OCS_dMGvdzBDmAwjPL5yBviFvRD5mJexyX8crsmE3eOpC2s59eP6pWDo1NOCj5VXiekuRl2zd3MTSRoJ2iECaKoDD1o10BpYfI5isjqLKBvjVwUpvULlupq3vFC12-w="
                }
              ],
              "connections" : [],
              "time" : 1,
              "currency" : "EUR",
              "currency_rate" : 1,
              "fx_rate" : 1,
              "refresh" : [],
              "del" : 2.826162,
              "ref_tasks" : [],
              "search_params" : {
                "flyFrom_type" : "airport",
                "to_type" : "city",
                "seats" : {
                  "passengers" : 1,
                  "adults" : 1,
                  "children" : 0,
                  "infants" : 0
                }
              },
              "all_stopover_airports" : [],
              "all_airlines" : [],
              "_results" : 5
            }

    """
    
}
