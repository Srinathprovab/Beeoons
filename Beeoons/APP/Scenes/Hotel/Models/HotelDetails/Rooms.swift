

import Foundation
struct Rooms : Codable {
	let xml_currency : String?
	let xml_net : String?
	let roomid : String?
	let roomtype : String?
	let refundable : String?
	let roomDescription : String?
	let board : String?
	let currency : String?
	let net : Double?
	let cancellationPolicies : [CancellationPolicies]?

	enum CodingKeys: String, CodingKey {

		case xml_currency = "xml_currency"
		case xml_net = "xml_net"
		case roomid = "roomid"
		case roomtype = "roomtype"
		case refundable = "Refundable"
		case roomDescription = "RoomDescription"
		case board = "Board"
		case currency = "currency"
		case net = "net"
		case cancellationPolicies = "cancellationPolicies"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
		xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
		roomid = try values.decodeIfPresent(String.self, forKey: .roomid)
		roomtype = try values.decodeIfPresent(String.self, forKey: .roomtype)
		refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
		roomDescription = try values.decodeIfPresent(String.self, forKey: .roomDescription)
		board = try values.decodeIfPresent(String.self, forKey: .board)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		net = try values.decodeIfPresent(Double.self, forKey: .net)
		cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
	}

}
