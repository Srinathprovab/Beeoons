




import Foundation
struct SelectCityModel : Codable {
    let city : String?
    let label : String?
    let value : String?
    let country : String?
    let code : String?
    let airport_name : String?
    let id : String?
    let category : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case city = "city"
        case label = "label"
        case value = "value"
        case country = "country"
        case code = "code"
        case airport_name = "airport_name"
        case id = "id"
        case category = "category"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
