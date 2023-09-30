
import Foundation
struct Hotel_search_params : Codable {
	let from_date : String?
	let to_date : String?
	let no_of_nights : Int?
	let hotel_destination : String?
	let location : String?
	let city_name : String?
	let country_name : String?
	let location_en : String?
	let city_name_en : String?
	let country_name_en : String?
	let location_ar : String?
	let city_name_ar : String?
	let country_name_ar : String?
	let room_count : Int?
	let adult_config : [String]?
	let child_config : [String]?
	let is_domestic : Bool?
	let nationality : String?
	let lang : String?
	let search_id : Int?

	enum CodingKeys: String, CodingKey {

		case from_date = "from_date"
		case to_date = "to_date"
		case no_of_nights = "no_of_nights"
		case hotel_destination = "hotel_destination"
		case location = "location"
		case city_name = "city_name"
		case country_name = "country_name"
		case location_en = "location_en"
		case city_name_en = "city_name_en"
		case country_name_en = "country_name_en"
		case location_ar = "location_ar"
		case city_name_ar = "city_name_ar"
		case country_name_ar = "country_name_ar"
		case room_count = "room_count"
		case adult_config = "adult_config"
		case child_config = "child_config"
		case is_domestic = "is_domestic"
		case nationality = "nationality"
		case lang = "lang"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
		hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
		location_en = try values.decodeIfPresent(String.self, forKey: .location_en)
		city_name_en = try values.decodeIfPresent(String.self, forKey: .city_name_en)
		country_name_en = try values.decodeIfPresent(String.self, forKey: .country_name_en)
		location_ar = try values.decodeIfPresent(String.self, forKey: .location_ar)
		city_name_ar = try values.decodeIfPresent(String.self, forKey: .city_name_ar)
		country_name_ar = try values.decodeIfPresent(String.self, forKey: .country_name_ar)
		room_count = try values.decodeIfPresent(Int.self, forKey: .room_count)
		adult_config = try values.decodeIfPresent([String].self, forKey: .adult_config)
		child_config = try values.decodeIfPresent([String].self, forKey: .child_config)
		is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
		nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
		lang = try values.decodeIfPresent(String.self, forKey: .lang)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
	}

}
