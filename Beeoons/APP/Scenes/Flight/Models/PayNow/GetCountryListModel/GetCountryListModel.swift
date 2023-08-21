//
//  GetCountryListModel.swift
//  Beeoons
//
//  Created by FCI on 21/08/23.
//

import Foundation

struct GetCountrySelectModel: Codable {
    let country_ISO : String?
    let country_Name_EN : String?

    enum CodingKeys: String, CodingKey {

        case country_ISO = "Country_ISO"
        case country_Name_EN = "Country_Name_EN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_ISO = try values.decodeIfPresent(String.self, forKey: .country_ISO)
        country_Name_EN = try values.decodeIfPresent(String.self, forKey: .country_Name_EN)
    }

}
