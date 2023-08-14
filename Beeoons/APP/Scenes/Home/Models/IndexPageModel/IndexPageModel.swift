//
//  IndexPageModel.swift
//  Beeoons
//
//  Created by FCI on 14/08/23.
//

import Foundation


struct IndexPageModel : Codable {
    let base_url : String?
    let flight_top_destinations1 : [Flight_top_destinations1]?
    let flight_hotel_top_destinations : [Flight_hotel_top_destinations]?
    let top_dest_hotel : [Top_dest_hotel]?
    let perfect_holidays : [Perfect_holidays]?
   

    enum CodingKeys: String, CodingKey {

        case base_url = "base_url"
        case flight_top_destinations1 = "flight_top_destinations1"
        case flight_hotel_top_destinations = "flight_hotel_top_destinations"
        case top_dest_hotel = "top_dest_hotel"
        case perfect_holidays = "perfect_holidays"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        base_url = try values.decodeIfPresent(String.self, forKey: .base_url)
        flight_top_destinations1 = try values.decodeIfPresent([Flight_top_destinations1].self, forKey: .flight_top_destinations1)
        flight_hotel_top_destinations = try values.decodeIfPresent([Flight_hotel_top_destinations].self, forKey: .flight_hotel_top_destinations)
        top_dest_hotel = try values.decodeIfPresent([Top_dest_hotel].self, forKey: .top_dest_hotel)
        perfect_holidays = try values.decodeIfPresent([Perfect_holidays].self, forKey: .perfect_holidays)
       
    }

}
