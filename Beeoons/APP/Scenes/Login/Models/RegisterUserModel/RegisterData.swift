//
//  RegisterData.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

struct RegisterData : Codable {
    let status : Int?
    let user_id : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
    }

}
