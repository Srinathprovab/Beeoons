//
//  LogoutModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

struct LogoutModel : Codable {
    
    let status : Bool?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
