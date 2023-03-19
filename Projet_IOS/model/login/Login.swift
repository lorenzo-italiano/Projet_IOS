//
//  Login.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

class Login: Encodable {
    
    @Published var email : String
    @Published var password : String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
    
}
