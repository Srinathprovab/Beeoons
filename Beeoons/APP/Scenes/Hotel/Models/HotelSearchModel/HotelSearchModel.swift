//
//  HotelSearchModel.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import Foundation


struct HotelSearchModel : Codable {
    let data : HotelSearchData?
    let msg : String?
    let status : Int?
    let search_params : String?
    let total_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?
    let booking_source : String?
    let search_id : String?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case search_params = "search_params"
        case total_result_count = "total_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case booking_source = "booking_source"
        case search_id = "search_id"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HotelSearchData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        search_params = try values.decodeIfPresent(String.self, forKey: .search_params)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}
