//
//  LoginModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

struct LoginModel : Codable {
    
    let status : Bool?
    let user_id : String?
    let first_name : String?
    let last_name : String?
    let image : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case image = "image"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}
