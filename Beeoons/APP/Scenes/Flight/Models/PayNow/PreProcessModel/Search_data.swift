/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Search_data : Codable {
	let trip_type : String?
	let depature : String?
	let trip_type_label : String?
	let from : String?
	let from_loc_id : String?
	let to : String?
	let to_loc_id : String?
	let from_loc : String?
	let from_loc_country : String?
	let to_loc : String?
	let to_loc_country : String?
	let from_ar : String?
	let to_ar : String?
	let from_en : String?
	let to_en : String?
	let total_pax : Int?
	let adult_config : String?
	let child_config : String?
	let infant_config : String?
	let v_class : String?
	let carrier : String?
	let deal_type : String?
	let is_domestic : Bool?
	let search_id : Int?
	let search_req_pax_detail : String?
	let search_module : String?
	let temp_hotel_booking : String?

	enum CodingKeys: String, CodingKey {

		case trip_type = "trip_type"
		case depature = "depature"
		case trip_type_label = "trip_type_label"
		case from = "from"
		case from_loc_id = "from_loc_id"
		case to = "to"
		case to_loc_id = "to_loc_id"
		case from_loc = "from_loc"
		case from_loc_country = "from_loc_country"
		case to_loc = "to_loc"
		case to_loc_country = "to_loc_country"
		case from_ar = "from_ar"
		case to_ar = "to_ar"
		case from_en = "from_en"
		case to_en = "to_en"
		case total_pax = "total_pax"
		case adult_config = "adult_config"
		case child_config = "child_config"
		case infant_config = "infant_config"
		case v_class = "v_class"
		case carrier = "carrier"
		case deal_type = "deal_type"
		case is_domestic = "is_domestic"
		case search_id = "search_id"
		case search_req_pax_detail = "search_req_pax_detail"
		case search_module = "search_module"
		case temp_hotel_booking = "temp_hotel_booking"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		depature = try values.decodeIfPresent(String.self, forKey: .depature)
		trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
		from_ar = try values.decodeIfPresent(String.self, forKey: .from_ar)
		to_ar = try values.decodeIfPresent(String.self, forKey: .to_ar)
		from_en = try values.decodeIfPresent(String.self, forKey: .from_en)
		to_en = try values.decodeIfPresent(String.self, forKey: .to_en)
		total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
		adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
		child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
		infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
		v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
		carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
		deal_type = try values.decodeIfPresent(String.self, forKey: .deal_type)
		is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
		search_req_pax_detail = try values.decodeIfPresent(String.self, forKey: .search_req_pax_detail)
		search_module = try values.decodeIfPresent(String.self, forKey: .search_module)
		temp_hotel_booking = try values.decodeIfPresent(String.self, forKey: .temp_hotel_booking)
	}

}