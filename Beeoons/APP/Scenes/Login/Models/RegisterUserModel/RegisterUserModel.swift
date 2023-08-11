//
//  RegisterUserModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation


struct RegisterUserModel : Codable {
    let status : Bool?
    let msg : String?
    let data : RegisterData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(RegisterData.self, forKey: .data)
    }

}
