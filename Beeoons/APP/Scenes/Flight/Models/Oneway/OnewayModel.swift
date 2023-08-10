//
//  OnewayModel.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import Foundation

struct OnewayModel : Codable {
    let data : FlightData?
    let msg : String?
    let status : Int?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FlightData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}
