//
//  PrePaymentConfModel.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import Foundation
struct PrePaymentConfModel : Codable {
    
    //    let booking_data : Booking_data?
    //    let search_data : Search_data?
    //    let baggageAmount : Int?
    //    let mealsAmount : Int?
    //    let extra_services_amount : Int?
    //    let convenience_fees : String?
    //    let booking_source : String?
    //    let session_expiry_details : Session_expiry_details?
    //    let promocode_val : String?
    //    let converted_currency_rate : Int?
    //    let converted_currency_rate_pay : Int?
    let form_url : String?
    let msg : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        //        case booking_data = "booking_data"
        //        case search_data = "search_data"
        //        case baggageAmount = "baggageAmount"
        //        case mealsAmount = "mealsAmount"
        //        case extra_services_amount = "extra_services_amount"
        //        case convenience_fees = "convenience_fees"
        //        case booking_source = "booking_source"
        //        case session_expiry_details = "session_expiry_details"
        //        case promocode_val = "promocode_val"
        //        case converted_currency_rate = "converted_currency_rate"
        //        case converted_currency_rate_pay = "converted_currency_rate_pay"
        case form_url = "form_url"
        case msg = "msg"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        booking_data = try values.decodeIfPresent(Booking_data.self, forKey: .booking_data)
        //        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        //        baggageAmount = try values.decodeIfPresent(Int.self, forKey: .baggageAmount)
        //        mealsAmount = try values.decodeIfPresent(Int.self, forKey: .mealsAmount)
        //        extra_services_amount = try values.decodeIfPresent(Int.self, forKey: .extra_services_amount)
        //        convenience_fees = try values.decodeIfPresent(String.self, forKey: .convenience_fees)
        //        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        //        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
        //        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        //        converted_currency_rate_pay = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate_pay)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
