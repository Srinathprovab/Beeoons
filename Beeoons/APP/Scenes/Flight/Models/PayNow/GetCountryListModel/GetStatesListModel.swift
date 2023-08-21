//
//  GetStatesListModel.swift
//  Beeoons
//
//  Created by FCI on 21/08/23.
//

import Foundation


struct GetStatesListModel : Codable {
    let msg : String?
    let status : Bool?
    let data : [StatesList]?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([StatesList].self, forKey: .data)
    }

}
