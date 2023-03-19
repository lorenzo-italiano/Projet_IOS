//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

class Volunteer: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: Volunteer, rhs: Volunteer) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.profilePicture == rhs.profilePicture && lhs.password == rhs.password && lhs.isAdmin == rhs.isAdmin && lhs.email == rhs.email
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Published var id: String
    @Published var email : String
    @Published var surname : String
    @Published var name : String
    @Published var profilePicture : String?
    @Published var password : String
    @Published var isAdmin : Bool

    init(id: String, email: String, surname: String, name: String, profilePicture: String?, password: String, isAdmin: Bool) {
        self.id = id
        self.email = email
        self.surname = surname
        self.name = name
        self.profilePicture = profilePicture
        self.password = password
        self.isAdmin = isAdmin

    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email = "email"
        case name = "name"
        case surname = "surname"
        case profilePicture = "profile_picture"
        case password = "password"
        case isAdmin = "isAdmin"
    }

    required init(from decoder: Decoder) throws {

        let IDContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try IDContainer.decode(String.self, forKey: .id)

        let emailContainer = try decoder.container(keyedBy: CodingKeys.self)
        email = try emailContainer.decode(String.self, forKey: .email)

        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let surnameContainer = try decoder.container(keyedBy: CodingKeys.self)
        surname = try surnameContainer.decode(String.self, forKey: .surname)

        let profilePictureContainer = try decoder.container(keyedBy: CodingKeys.self)
        profilePicture = try profilePictureContainer.decodeIfPresent(String.self, forKey: .profilePicture)

        let passwordContainer = try decoder.container(keyedBy: CodingKeys.self)
        password = try passwordContainer.decode(String.self, forKey: .password)

        let isAdminContainer = try decoder.container(keyedBy: CodingKeys.self)
        isAdmin = try isAdminContainer.decode(Bool.self, forKey: .isAdmin)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(surname, forKey: .surname)
        try container.encode(name, forKey: .name)
        try container.encode(profilePicture, forKey: .profilePicture)
        try container.encode(password, forKey: .password)
        try container.encode(isAdmin, forKey: .isAdmin)
    }

}
