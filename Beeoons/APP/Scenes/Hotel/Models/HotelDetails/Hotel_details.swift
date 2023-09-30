

import Foundation
struct Hotel_details : Codable {
	let booking_source : String?
	let hotel_code : String?
	let city_code : String?
	let country_code : String?
	let name : String?
	let address : String?
	let phone_number : String?
	let fax : String?
	let email : String?
	let website : String?
	let hotel_desc : String?
	let hotel_faci : String?
	let image : String?
	let thumb_image : String?
	let images : String?
	let accomodation_cstr : String?
	let location : String?
	let star_rating : String?
	let latitude : String?
	let longitude : String?
	let facility_cstr : String?
	let facility : String?
	let facility_search : String?
	let extra_details : String?
	let price : Double?
	let hotel_details_room : String?
	let currency : String?
	let resultIndex : String?
	let frmpd : String?
	let data_source : String?
	let session_id : String?
	let refundable : String?
	let refundableKey : String?
	let boardType : String?
	let rooms : [[Rooms]]?
	let minRate : Double?
	let maxRate : Double?
	let checkIn : String?
	let checkOut : String?
	let token : String?
	let tokenKey : String?
	let format_ame : [String]?
	let format_desc : String?

	enum CodingKeys: String, CodingKey {

		case booking_source = "booking_source"
		case hotel_code = "hotel_code"
		case city_code = "city_code"
		case country_code = "country_code"
		case name = "name"
		case address = "address"
		case phone_number = "phone_number"
		case fax = "fax"
		case email = "email"
		case website = "website"
		case hotel_desc = "hotel_desc"
		case hotel_faci = "hotel_faci"
		case image = "image"
		case thumb_image = "thumb_image"
		case images = "images"
		case accomodation_cstr = "accomodation_cstr"
		case location = "location"
		case star_rating = "star_rating"
		case latitude = "latitude"
		case longitude = "longitude"
		case facility_cstr = "facility_cstr"
		case facility = "facility"
		case facility_search = "facility_search"
		case extra_details = "extra_details"
		case price = "price"
		case hotel_details_room = "hotel_details_room"
		case currency = "currency"
		case resultIndex = "ResultIndex"
		case frmpd = "frmpd"
		case data_source = "data_source"
		case session_id = "session_id"
		case refundable = "Refundable"
		case refundableKey = "RefundableKey"
		case boardType = "BoardType"
		case rooms = "Rooms"
		case minRate = "minRate"
		case maxRate = "maxRate"
		case checkIn = "checkIn"
		case checkOut = "checkOut"
		case token = "Token"
		case tokenKey = "TokenKey"
		case format_ame = "format_ame"
		case format_desc = "format_desc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
		city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
		fax = try values.decodeIfPresent(String.self, forKey: .fax)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		hotel_desc = try values.decodeIfPresent(String.self, forKey: .hotel_desc)
		hotel_faci = try values.decodeIfPresent(String.self, forKey: .hotel_faci)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
		images = try values.decodeIfPresent(String.self, forKey: .images)
		accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
		facility = try values.decodeIfPresent(String.self, forKey: .facility)
		facility_search = try values.decodeIfPresent(String.self, forKey: .facility_search)
		extra_details = try values.decodeIfPresent(String.self, forKey: .extra_details)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		hotel_details_room = try values.decodeIfPresent(String.self, forKey: .hotel_details_room)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		resultIndex = try values.decodeIfPresent(String.self, forKey: .resultIndex)
		frmpd = try values.decodeIfPresent(String.self, forKey: .frmpd)
		data_source = try values.decodeIfPresent(String.self, forKey: .data_source)
		session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
		refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
		refundableKey = try values.decodeIfPresent(String.self, forKey: .refundableKey)
		boardType = try values.decodeIfPresent(String.self, forKey: .boardType)
		rooms = try values.decodeIfPresent([[Rooms]].self, forKey: .rooms)
		minRate = try values.decodeIfPresent(Double.self, forKey: .minRate)
		maxRate = try values.decodeIfPresent(Double.self, forKey: .maxRate)
		checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
		checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
		format_ame = try values.decodeIfPresent([String].self, forKey: .format_ame)
		format_desc = try values.decodeIfPresent(String.self, forKey: .format_desc)
	}

}
