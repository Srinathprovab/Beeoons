//
//  StatesList.swift
//  Beeoons
//
//  Created by FCI on 21/08/23.
//

import Foundation

struct StatesList : Codable {
    let abbreviation : String?
    let name_en : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case abbreviation = "abbreviation"
        case name_en = "name_en"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abbreviation = try values.decodeIfPresent(String.self, forKey: .abbreviation)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
