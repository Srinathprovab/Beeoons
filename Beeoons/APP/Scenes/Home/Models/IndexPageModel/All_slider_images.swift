

import Foundation
struct All_slider_images : Codable {
	let image_path : String?
	let slider_content : String?
	let use_type : String?
	let position : String?
	let link : String?
	let target : String?

	enum CodingKeys: String, CodingKey {

		case image_path = "image_path"
		case slider_content = "slider_content"
		case use_type = "use_type"
		case position = "position"
		case link = "link"
		case target = "target"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
		slider_content = try values.decodeIfPresent(String.self, forKey: .slider_content)
		use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
		position = try values.decodeIfPresent(String.self, forKey: .position)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		target = try values.decodeIfPresent(String.self, forKey: .target)
	}

}
