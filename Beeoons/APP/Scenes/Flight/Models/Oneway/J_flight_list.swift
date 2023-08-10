

import Foundation
struct J_flight_list : Codable {
    let airPricingSolution_Key : String?
    let completeItinerary : String?
    let connections : String?
    let totalPrice : String?
    let basePrice : String?
    let taxes : String?
    let totalPrice_API : String?
    let aPICurrencyType : String?
    let sITECurrencyType : String?
    let myMarkup : String?
    let myMarkup_cal : String?
    let aMarkup : String?
    let aMarkup_cal : String?
    //	let refundable : Bool?
    let platingCarrier : String?
    let adults : Int?
    let adults_Base_Price : String?
    let adults_Tax_Price : String?
    let fareTypeName : String?
    let fareTypeName_id : String?
    let admin_markup_amount : Int?
    let agent_markup_amount : Int?
    let fareType : String?
    let onward_TravelTime : String?
    let travelTime : String?
    let trip_type : String?
    //	let flightNumber_no : [String]?
    //	let penalties : [String]?
    //	let farerulesref_Key : [String]?
    //	let farerulesref_Provider : [String]?
    //	let farerulesref_content : [String]?
    let flight_details : Flight_details?
    let price : Price?
    let access_key : String?
    let selectedResult : String?
    
    enum CodingKeys: String, CodingKey {
        
        case airPricingSolution_Key = "AirPricingSolution_Key"
        case completeItinerary = "CompleteItinerary"
        case connections = "Connections"
        case totalPrice = "TotalPrice"
        case basePrice = "BasePrice"
        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
        case sITECurrencyType = "SITECurrencyType"
        case myMarkup = "MyMarkup"
        case myMarkup_cal = "myMarkup_cal"
        case aMarkup = "aMarkup"
        case aMarkup_cal = "aMarkup_cal"
        //	case refundable = "Refundable"
        case platingCarrier = "PlatingCarrier"
        case adults = "Adults"
        case adults_Base_Price = "Adults_Base_Price"
        case adults_Tax_Price = "Adults_Tax_Price"
        case fareTypeName = "FareTypeName"
        case fareTypeName_id = "FareTypeName_id"
        case admin_markup_amount = "admin_markup_amount"
        case agent_markup_amount = "agent_markup_amount"
        case fareType = "FareType"
        case onward_TravelTime = "Onward_TravelTime"
        case travelTime = "TravelTime"
        case trip_type = "trip_type"
        //		case flightNumber_no = "FlightNumber_no"
        //		case penalties = "penalties"
        //		case farerulesref_Key = "Farerulesref_Key"
        //		case farerulesref_Provider = "Farerulesref_Provider"
        //		case farerulesref_content = "Farerulesref_content"
        case flight_details = "flight_details"
        case price = "price"
        case access_key = "access_key"
        case selectedResult = "selectedResult"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airPricingSolution_Key = try values.decodeIfPresent(String.self, forKey: .airPricingSolution_Key)
        completeItinerary = try values.decodeIfPresent(String.self, forKey: .completeItinerary)
        connections = try values.decodeIfPresent(String.self, forKey: .connections)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
        myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
        aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
        aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
        //		refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        adults_Base_Price = try values.decodeIfPresent(String.self, forKey: .adults_Base_Price)
        adults_Tax_Price = try values.decodeIfPresent(String.self, forKey: .adults_Tax_Price)
        fareTypeName = try values.decodeIfPresent(String.self, forKey: .fareTypeName)
        fareTypeName_id = try values.decodeIfPresent(String.self, forKey: .fareTypeName_id)
        admin_markup_amount = try values.decodeIfPresent(Int.self, forKey: .admin_markup_amount)
        agent_markup_amount = try values.decodeIfPresent(Int.self, forKey: .agent_markup_amount)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        onward_TravelTime = try values.decodeIfPresent(String.self, forKey: .onward_TravelTime)
        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        //		flightNumber_no = try values.decodeIfPresent([String].self, forKey: .flightNumber_no)
        //		penalties = try values.decodeIfPresent([String].self, forKey: .penalties)
        //		farerulesref_Key = try values.decodeIfPresent([String].self, forKey: .farerulesref_Key)
        //		farerulesref_Provider = try values.decodeIfPresent([String].self, forKey: .farerulesref_Provider)
        //		farerulesref_content = try values.decodeIfPresent([String].self, forKey: .farerulesref_content)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
    }
    
}
