

import Foundation
struct CancellationPolicies : Codable {
	let amount : Double?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
	}

}
