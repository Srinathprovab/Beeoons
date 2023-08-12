//
//  LoginData.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

struct LoginData : Codable {
    let email : String?

    enum CodingKeys: String, CodingKey {

        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}
