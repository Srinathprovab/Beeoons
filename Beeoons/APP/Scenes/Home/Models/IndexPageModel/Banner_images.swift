
import Foundation
struct Banner_images : Codable {
	let status : Int?
	let data : [Banner_imagesData]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		data = try values.decodeIfPresent([Banner_imagesData].self, forKey: .data)
	}

}



struct Banner_imagesData : Codable {
    let image : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
