

import Foundation
struct BaggageAllowance : Codable {
	let aDT : String?
	let iNF : String?
	let cNN : String?
	let cabin_baggage : String?
	let journeySummary : String?

	enum CodingKeys: String, CodingKey {

		case aDT = "ADT"
		case iNF = "INF"
		case cNN = "CNN"
		case cabin_baggage = "cabin_baggage"
		case journeySummary = "journeySummary"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aDT = try values.decodeIfPresent(String.self, forKey: .aDT)
		iNF = try values.decodeIfPresent(String.self, forKey: .iNF)
		cNN = try values.decodeIfPresent(String.self, forKey: .cNN)
		cabin_baggage = try values.decodeIfPresent(String.self, forKey: .cabin_baggage)
		journeySummary = try values.decodeIfPresent(String.self, forKey: .journeySummary)
	}

}
