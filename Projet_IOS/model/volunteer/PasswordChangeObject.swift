//
// Created by Lorenzo Italiano on 02/04/2023.
//

import Foundation

class PasswordChangeObject: ObservableObject, Hashable, Equatable, Codable {

    @Published var currentPassword: String
    @Published var newPassword : String

    init() {
        self.currentPassword = ""
        self.newPassword = ""
    }

    init(currentPassword: String, newPassword: String) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
    }


    private enum CodingKeys: String, CodingKey {
        case currentPassword = "currentPassword"
        case newPassword = "newPassword"
    }

    required init(from decoder: Decoder) throws {

        let currentPasswordContainer = try decoder.container(keyedBy: CodingKeys.self)
        currentPassword = try currentPasswordContainer.decode(String.self, forKey: .currentPassword)

        let newPasswordContainer = try decoder.container(keyedBy: CodingKeys.self)
        newPassword = try newPasswordContainer.decode(String.self, forKey: .newPassword)

    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(currentPassword, forKey: .currentPassword)
        try container.encode(newPassword, forKey: .newPassword)
    }

    static func == (lhs: PasswordChangeObject, rhs: PasswordChangeObject) -> Bool {
        return lhs.currentPassword == rhs.currentPassword && lhs.newPassword == rhs.newPassword
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(newPassword)
    }
}
