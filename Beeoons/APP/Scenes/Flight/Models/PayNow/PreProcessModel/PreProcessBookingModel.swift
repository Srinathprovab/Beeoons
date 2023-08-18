//
//  PreProcessBookingModel.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import Foundation

struct PreProcessBookingModel : Codable {
    let access_key_tp : String?
    let flight_data : Flight_data?
    let active_payment_options : [String]?
    let booking_source : String?
    let tmp_flight_pre_booking_id : String?
    let pre_booking_params : Pre_booking_params?
    //    let form_params : Form_params?
    // let search_data : Search_data?
    let pax_details : Bool?
    let session_expiry_details : Session_expiry_details?
    let converted_currency_rate : Int?
    let flight_terms_cancellation_policy : String?
    let total_trip_cost : Double?
    let trip_type : String?
    let mybookingsource : String?
    let seo : String?
    
    enum CodingKeys: String, CodingKey {
        
        case access_key_tp = "access_key_tp"
        case flight_data = "flight_data"
        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case pre_booking_params = "pre_booking_params"
        //        case form_params = "form_params"
        // case search_data = "search_data"
        case pax_details = "pax_details"
        case session_expiry_details = "session_expiry_details"
        case converted_currency_rate = "converted_currency_rate"
        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        case total_trip_cost = "total_trip_cost"
        case trip_type = "trip_type"
        case mybookingsource = "mybookingsource"
        case seo = "seo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        flight_data = try values.decodeIfPresent(Flight_data.self, forKey: .flight_data)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        pre_booking_params = try values.decodeIfPresent(Pre_booking_params.self, forKey: .pre_booking_params)
        //        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        //  search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        total_trip_cost = try values.decodeIfPresent(Double.self, forKey: .total_trip_cost)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        mybookingsource = try values.decodeIfPresent(String.self, forKey: .mybookingsource)
        seo = try values.decodeIfPresent(String.self, forKey: .seo)
    }
    
}
