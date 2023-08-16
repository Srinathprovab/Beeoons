//
//  FlightDetailsModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

struct FlightDetailsModel : Codable {
    let status : Bool?
    let flightDetails : [[FlightDetails]]?
    let baggageAllowance : [BaggageAllowance]?
    let priceDetails : PriceDetails?
    let fareRulehtml : [FareRulehtml]?
    let fare_rule_ref_key : String?
    let farerulesref_content : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case flightDetails = "flightDetails"
        case baggageAllowance = "BaggageAllowance"
        case priceDetails = "priceDetails"
        case fareRulehtml = "fareRulehtml"
        case fare_rule_ref_key = "fare_rule_ref_key"
        case farerulesref_content = "farerulesref_content"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        flightDetails = try values.decodeIfPresent([[FlightDetails]].self, forKey: .flightDetails)
        baggageAllowance = try values.decodeIfPresent([BaggageAllowance].self, forKey: .baggageAllowance)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
        fareRulehtml = try values.decodeIfPresent([FareRulehtml].self, forKey: .fareRulehtml)
        fare_rule_ref_key = try values.decodeIfPresent(String.self, forKey: .fare_rule_ref_key)
        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
    }

}
