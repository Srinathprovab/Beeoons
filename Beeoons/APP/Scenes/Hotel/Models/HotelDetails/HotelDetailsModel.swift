//
//  HotelDetailsModel.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import Foundation

struct HotelDetailsModel : Codable {
    
    let currency_obj : Currency_obj?
    let hotel_details : Hotel_details?
    let hotel_search_params : Hotel_search_params?
    let search_module : String?
    let active_booking_source : String?
    let params : Params?
    let session_expiry_details : Session_expiry_details?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case currency_obj = "currency_obj"
        case hotel_details = "hotel_details"
        case hotel_search_params = "hotel_search_params"
        case search_module = "search_module"
        case active_booking_source = "active_booking_source"
        case params = "params"
        case session_expiry_details = "session_expiry_details"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        hotel_search_params = try values.decodeIfPresent(Hotel_search_params.self, forKey: .hotel_search_params)
        search_module = try values.decodeIfPresent(String.self, forKey: .search_module)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
