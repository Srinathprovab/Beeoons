/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Top_dest_hotel : Codable {
	let id : String?
	let city_name : String?
	let city : String?
	let check_in : String?
	let check_out : String?
	let image : String?
	let price : String?
	let hotel_code : String?
	let giata_id : String?
	let hotel_name : String?
	let title : String?
	let hotel_text : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case city_name = "city_name"
		case city = "city"
		case check_in = "check_in"
		case check_out = "check_out"
		case image = "image"
		case price = "price"
		case hotel_code = "hotel_code"
		case giata_id = "giata_id"
		case hotel_name = "hotel_name"
		case title = "title"
		case hotel_text = "hotel_text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
		check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
		giata_id = try values.decodeIfPresent(String.self, forKey: .giata_id)
		hotel_name = try values.decodeIfPresent(String.self, forKey: .hotel_name)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		hotel_text = try values.decodeIfPresent(String.self, forKey: .hotel_text)
	}

}