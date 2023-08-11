

import Foundation
struct Country_list : Codable {
	let origin : String?
	let api_continent_list_fk : String?
	let name : String?
	let name_ar : String?
	let country_code : String?
	let iso_country_code : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case api_continent_list_fk = "api_continent_list_fk"
		case name = "name"
		case name_ar = "name_ar"
		case country_code = "country_code"
		case iso_country_code = "iso_country_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		api_continent_list_fk = try values.decodeIfPresent(String.self, forKey: .api_continent_list_fk)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		iso_country_code = try values.decodeIfPresent(String.self, forKey: .iso_country_code)
	}

}
