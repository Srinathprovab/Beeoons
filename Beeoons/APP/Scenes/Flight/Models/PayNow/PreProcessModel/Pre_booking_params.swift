

import Foundation
struct Pre_booking_params : Codable {
	let promocode_discount_val : String?
	let promocode_discount_type : String?
	let token : String?
	let token_key : String?
	let booking_source : String?
	let access_key : String?
	let search_id : String?
	let user_id : String?
	let transaction_id : String?

	enum CodingKeys: String, CodingKey {

		case promocode_discount_val = "promocode_discount_val"
		case promocode_discount_type = "promocode_discount_type"
		case token = "token"
		case token_key = "token_key"
		case booking_source = "booking_source"
		case access_key = "access_key"
		case search_id = "search_id"
		case user_id = "user_id"
		case transaction_id = "transaction_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		promocode_discount_val = try values.decodeIfPresent(String.self, forKey: .promocode_discount_val)
		promocode_discount_type = try values.decodeIfPresent(String.self, forKey: .promocode_discount_type)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
	}

}
