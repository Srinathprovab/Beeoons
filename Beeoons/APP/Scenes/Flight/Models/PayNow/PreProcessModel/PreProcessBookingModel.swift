//
//  PreProcessBookingModel.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import Foundation

struct PreProcessBookingModel : Codable {
    let promocode_discount_val : String?
    let trip_type : String?
    let promocode_discount_type : String?
    //  let flight_details : Flight_details?
    let search_data : PreProcessSearch_data?
    let mybookingsource : String?
    let token_key : String?
    let tmp_flight_pre_booking_id : String?
    let pax_details : Bool?
    let user_id : String?
    let access_key_tp : String?
    let session_expiry_details : Session_expiry_details?
    let total_trip_cost : Double?
    let booking_source : String?
    //   let form_params : Form_params?
    let search_id : String?
    let flight_terms_cancellation_policy : String?
    let total_price : Int?
    let converted_currency_rate : Int?
    let access_key : String?
    
    enum CodingKeys: String, CodingKey {
        
        case promocode_discount_val = "promocode_discount_val"
        case trip_type = "trip_type"
        case promocode_discount_type = "promocode_discount_type"
        //     case flight_details = "flight_details"
        case search_data = "search_data"
        case mybookingsource = "mybookingsource"
        case token_key = "token_key"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case pax_details = "pax_details"
        case user_id = "user_id"
        case access_key_tp = "access_key_tp"
        case session_expiry_details = "session_expiry_details"
        case total_trip_cost = "total_trip_cost"
        case booking_source = "booking_source"
        //      case form_params = "form_params"
        case search_id = "search_id"
        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        case total_price = "total_price"
        case converted_currency_rate = "converted_currency_rate"
        case access_key = "access_key"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        promocode_discount_val = try values.decodeIfPresent(String.self, forKey: .promocode_discount_val)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        promocode_discount_type = try values.decodeIfPresent(String.self, forKey: .promocode_discount_type)
        //     flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        search_data = try values.decodeIfPresent(PreProcessSearch_data.self, forKey: .search_data)
        mybookingsource = try values.decodeIfPresent(String.self, forKey: .mybookingsource)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        total_trip_cost = try values.decodeIfPresent(Double.self, forKey: .total_trip_cost)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //       form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        total_price = try values.decodeIfPresent(Int.self, forKey: .total_price)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
    }
    
}
