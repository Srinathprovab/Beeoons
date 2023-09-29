

import Foundation
struct Advertisement : Codable {
	let origin : String?
	let module_name : String?
	let url_link : String?
	let url_link_redirect : String?
	let image : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case module_name = "module_name"
		case url_link = "url_link"
		case url_link_redirect = "url_link_redirect"
		case image = "image"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		module_name = try values.decodeIfPresent(String.self, forKey: .module_name)
		url_link = try values.decodeIfPresent(String.self, forKey: .url_link)
		url_link_redirect = try values.decodeIfPresent(String.self, forKey: .url_link_redirect)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
