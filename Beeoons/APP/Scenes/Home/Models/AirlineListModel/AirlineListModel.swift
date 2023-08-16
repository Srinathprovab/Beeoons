//
//  AirlineListModel.swift
//  Beeoons
//
//  Created by FCI on 16/08/23.
//

import Foundation

struct AirlineListModel : Codable {
    let status : Bool?
    let airline_list : [Airline_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case airline_list = "airline_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        airline_list = try values.decodeIfPresent([Airline_list].self, forKey: .airline_list)
    }

}
