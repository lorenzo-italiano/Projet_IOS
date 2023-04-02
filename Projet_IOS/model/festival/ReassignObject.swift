//
// Created by Lorenzo Italiano on 02/04/2023.
//

import Foundation
import SwiftUI

class ReassignObject: ObservableObject, Hashable, Equatable, Codable {

    @Published var oldZone: String
    @Published var oldTimeslot: String
    @Published var newTimeslot: String
    @Published var volunteer: String

    init() {
        self.volunteer = ""
        self.oldZone = ""
        self.newTimeslot = ""
        self.oldTimeslot = ""
    }

    init(oldZone: String, oldTimeslot: String, newTimeslot: String, volunteer: String) {
        self.oldZone = oldZone
        self.oldTimeslot = oldTimeslot
        self.newTimeslot = newTimeslot
        self.volunteer = volunteer
    }

    private enum CodingKeys: String, CodingKey {
        case oldZone = "oldZone"
        case oldTimeslot = "oldTimeslot"
        case newTimeslot = "newTimeslot"
        case volunteer = "volunteer"
    }

    required init(from decoder: Decoder) throws {

        let oldZoneContainer = try decoder.container(keyedBy: CodingKeys.self)
        oldZone = try oldZoneContainer.decode(String.self, forKey: .oldZone)

        let oldTimeslotContainer = try decoder.container(keyedBy: CodingKeys.self)
        oldTimeslot = try oldTimeslotContainer.decode(String.self, forKey: .oldTimeslot)

        let newTimeslotContainer = try decoder.container(keyedBy: CodingKeys.self)
        newTimeslot = try newTimeslotContainer.decode(String.self, forKey: .newTimeslot)

        let volunteerContainer = try decoder.container(keyedBy: CodingKeys.self)
        volunteer = try volunteerContainer.decode(String.self, forKey: .volunteer)

    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(oldZone, forKey: .oldZone)
        try container.encode(oldTimeslot, forKey: .oldTimeslot)
        try container.encode(newTimeslot, forKey: .newTimeslot)
        try container.encode(volunteer, forKey: .volunteer)
    }

    static func == (lhs: ReassignObject, rhs: ReassignObject) -> Bool {
        return lhs.oldZone == rhs.oldZone && lhs.oldTimeslot == rhs.oldTimeslot && lhs.newTimeslot == rhs.newTimeslot && lhs.volunteer == rhs.volunteer
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(newTimeslot)
    }
}
