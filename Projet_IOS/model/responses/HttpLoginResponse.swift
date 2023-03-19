//
//  HttpLoginResponse.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

class HttpLoginResponse: Codable {
    
    @Published var msg : String
    @Published var token : String
//    @Published var user: String
//    @Published var user : Volu

    init(msg: String, token: String) {
        self.msg = msg
        self.token = token
    }

    private enum CodingKeys: String, CodingKey {
        case msg = "msg"
        case token = "token"
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(msg, forKey: .msg)
        try container.encode(token, forKey: .token)
    }
    
    required init(from decoder: Decoder) throws {

        let msgContainer = try decoder.container(keyedBy: CodingKeys.self)
        msg = try msgContainer.decode(String.self, forKey: .msg)
        
        let tokenContainer = try decoder.container(keyedBy: CodingKeys.self)
        token = try tokenContainer.decode(String.self, forKey: .token)
    }
    
}
