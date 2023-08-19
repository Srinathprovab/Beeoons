//
//  ShowVoucherData.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import Foundation


struct ShowVoucherData : Codable {
    //   let booking_details : [Booking_details]?
    let flight_details : Flight_details?
    //    let data : Data?
    let cancelltion_policy : String?
    let item : String?
    
    enum CodingKeys: String, CodingKey {
        
        //    case booking_details = "booking_details"
        case flight_details = "flight_details"
        //    case data = "data"
        case cancelltion_policy = "cancelltion_policy"
        case item = "item"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //    booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        //   data = try values.decodeIfPresent(Data.self, forKey: .data)
        cancelltion_policy = try values.decodeIfPresent(String.self, forKey: .cancelltion_policy)
        item = try values.decodeIfPresent(String.self, forKey: .item)
    }
    
}
