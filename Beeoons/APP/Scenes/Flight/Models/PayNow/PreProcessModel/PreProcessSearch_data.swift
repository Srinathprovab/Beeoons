//
//  PreProcessSearch_data.swift
//  Beeoons
//
//  Created by FCI on 04/10/23.
//

import Foundation

struct PreProcessSearch_data : Codable {
    let search_req_pax_detail : String?
    let child_config : String?
    let v_class : String?
    let is_domestic : Bool?
    let search_id : Int?
    let temp_hotel_booking : String?
    let infant_config : String?
    let to_loc : String?
    let from_en : String?
    let from_ar : String?
    let total_pax : Int?
    let search_module : String?
    let trip_type : String?
    let depature : String?
    let to : String?
    let carrier : String?
    let to_ar : String?
    let from : String?
    let to_loc_id : String?
    let from_loc_country : String?
    let from_loc_id : String?
    let to_loc_country : String?
    let deal_type : String?
    let adult_config : String?
    let trip_type_label : String?
    let from_loc : String?
    let to_en : String?

    enum CodingKeys: String, CodingKey {

        case search_req_pax_detail = "search_req_pax_detail"
        case child_config = "child_config"
        case v_class = "v_class"
        case is_domestic = "is_domestic"
        case search_id = "search_id"
        case temp_hotel_booking = "temp_hotel_booking"
        case infant_config = "infant_config"
        case to_loc = "to_loc"
        case from_en = "from_en"
        case from_ar = "from_ar"
        case total_pax = "total_pax"
        case search_module = "search_module"
        case trip_type = "trip_type"
        case depature = "depature"
        case to = "to"
        case carrier = "carrier"
        case to_ar = "to_ar"
        case from = "from"
        case to_loc_id = "to_loc_id"
        case from_loc_country = "from_loc_country"
        case from_loc_id = "from_loc_id"
        case to_loc_country = "to_loc_country"
        case deal_type = "deal_type"
        case adult_config = "adult_config"
        case trip_type_label = "trip_type_label"
        case from_loc = "from_loc"
        case to_en = "to_en"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_req_pax_detail = try values.decodeIfPresent(String.self, forKey: .search_req_pax_detail)
        child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        temp_hotel_booking = try values.decodeIfPresent(String.self, forKey: .temp_hotel_booking)
        infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        from_en = try values.decodeIfPresent(String.self, forKey: .from_en)
        from_ar = try values.decodeIfPresent(String.self, forKey: .from_ar)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        search_module = try values.decodeIfPresent(String.self, forKey: .search_module)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        depature = try values.decodeIfPresent(String.self, forKey: .depature)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        to_ar = try values.decodeIfPresent(String.self, forKey: .to_ar)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
        deal_type = try values.decodeIfPresent(String.self, forKey: .deal_type)
        adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
        trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        to_en = try values.decodeIfPresent(String.self, forKey: .to_en)
    }

}
