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
    let search_data : Search_data?
    let pax_details : Bool?
    let travel_date_diff : String?
    let session_expiry_details : Session_expiry_details?
    let converted_currency_rate : Int?
    let flight_terms_cancellation_policy : String?
    let total_price : Int?
    let reward_usable : Int?
    let reward_earned : Int?
    let total_price_with_rewards : Int?
    let mybookingsource : String?
    let seo : String?

    enum CodingKeys: String, CodingKey {

        case access_key_tp = "access_key_tp"
        case flight_data = "flight_data"
        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case search_data = "search_data"
        case pax_details = "pax_details"
        case travel_date_diff = "travel_date_diff"
        case session_expiry_details = "session_expiry_details"
        case converted_currency_rate = "converted_currency_rate"
        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        case total_price = "total_price"
        case reward_usable = "reward_usable"
        case reward_earned = "reward_earned"
        case total_price_with_rewards = "total_price_with_rewards"
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
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        travel_date_diff = try values.decodeIfPresent(String.self, forKey: .travel_date_diff)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        total_price = try values.decodeIfPresent(Int.self, forKey: .total_price)
        reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        mybookingsource = try values.decodeIfPresent(String.self, forKey: .mybookingsource)
        seo = try values.decodeIfPresent(String.self, forKey: .seo)
    }

}
