//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class SignUp: Encodable {

    @Published var name : String
    @Published var surname : String
    @Published var email : String
    @Published var password : String
    @Published var password_repeat : String

    init(name: String, surname: String, email: String, password: String, password_repeat: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.password_repeat = password_repeat
    }

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case surname = "surname"
        case email = "email"
        case password = "password"
        case password_repeat = "password_repeat"
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(surname, forKey: .surname)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(password_repeat, forKey: .password_repeat)
    }
}
