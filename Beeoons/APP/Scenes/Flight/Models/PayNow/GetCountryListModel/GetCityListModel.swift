//
//  GetCityListModel.swift
//  Beeoons
//
//  Created by FCI on 21/08/23.
//

import Foundation

struct GetCityListModel : Codable {
    let city_Name_EN : String?

    enum CodingKeys: String, CodingKey {

        case city_Name_EN = "City_Name_EN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_Name_EN = try values.decodeIfPresent(String.self, forKey: .city_Name_EN)
    }

}
