//
//  IndexPageModel.swift
//  Beeoons
//
//  Created by FCI on 14/08/23.
//

import Foundation


struct IndexPageModel : Codable {
    let base_url : String?
    let currency_obj : Currency_obj?
    let banner_images : Banner_images?
    let all_slider_images : [All_slider_images]?
    let slider_images_flight : Bool?
    let slider_images_hotel : Bool?
    let slider_images_car : Bool?
    let slider_images_holiday : Bool?
    let slider_images_transfer : Bool?
    let slider_images_activity : Bool?
    let slider_images_visa : Bool?
    let flight_top_destinations1 : [Flight_top_destinations1]?
    let flight_hotel_top_destinations : [Flight_hotel_top_destinations]?
    let top_dest_hotel : [Top_dest_hotel]?
    let perfect_holidays : [Perfect_holidays]?
    let advertisement : [Advertisement]?
    let site_content : [Site_content]?
    let currency_list : [Currency_list]?

    enum CodingKeys: String, CodingKey {

        case base_url = "base_url"
        case currency_obj = "currency_obj"
        case banner_images = "banner_images"
        case all_slider_images = "all_slider_images"
        case slider_images_flight = "slider_images_flight"
        case slider_images_hotel = "slider_images_hotel"
        case slider_images_car = "slider_images_car"
        case slider_images_holiday = "slider_images_holiday"
        case slider_images_transfer = "slider_images_transfer"
        case slider_images_activity = "slider_images_activity"
        case slider_images_visa = "slider_images_visa"
        case flight_top_destinations1 = "flight_top_destinations1"
        case flight_hotel_top_destinations = "flight_hotel_top_destinations"
        case top_dest_hotel = "top_dest_hotel"
        case perfect_holidays = "perfect_holidays"
        case advertisement = "advertisement"
        case site_content = "site_content"
        case currency_list = "currency_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        base_url = try values.decodeIfPresent(String.self, forKey: .base_url)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        banner_images = try values.decodeIfPresent(Banner_images.self, forKey: .banner_images)
        all_slider_images = try values.decodeIfPresent([All_slider_images].self, forKey: .all_slider_images)
        slider_images_flight = try values.decodeIfPresent(Bool.self, forKey: .slider_images_flight)
        slider_images_hotel = try values.decodeIfPresent(Bool.self, forKey: .slider_images_hotel)
        slider_images_car = try values.decodeIfPresent(Bool.self, forKey: .slider_images_car)
        slider_images_holiday = try values.decodeIfPresent(Bool.self, forKey: .slider_images_holiday)
        slider_images_transfer = try values.decodeIfPresent(Bool.self, forKey: .slider_images_transfer)
        slider_images_activity = try values.decodeIfPresent(Bool.self, forKey: .slider_images_activity)
        slider_images_visa = try values.decodeIfPresent(Bool.self, forKey: .slider_images_visa)
        flight_top_destinations1 = try values.decodeIfPresent([Flight_top_destinations1].self, forKey: .flight_top_destinations1)
        flight_hotel_top_destinations = try values.decodeIfPresent([Flight_hotel_top_destinations].self, forKey: .flight_hotel_top_destinations)
        top_dest_hotel = try values.decodeIfPresent([Top_dest_hotel].self, forKey: .top_dest_hotel)
        perfect_holidays = try values.decodeIfPresent([Perfect_holidays].self, forKey: .perfect_holidays)
        advertisement = try values.decodeIfPresent([Advertisement].self, forKey: .advertisement)
        site_content = try values.decodeIfPresent([Site_content].self, forKey: .site_content)
        currency_list = try values.decodeIfPresent([Currency_list].self, forKey: .currency_list)
    }

}
