//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class TimeslotVolunteerAssociation: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: TimeslotVolunteerAssociation, rhs: TimeslotVolunteerAssociation) -> Bool {
        return lhs.timeslot == rhs.timeslot && lhs.volunteerList == rhs.volunteerList
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(timeslot)
    }

    @Published var timeslot : String
    @Published var volunteerList : [String]

    init(timeslot: String, volunteerList: [String]) {
        self.timeslot = timeslot
        self.volunteerList = volunteerList
    }

    private enum CodingKeys: String, CodingKey {
        case timeslot = "timeslot"
        case volunteerList = "volunteerList"
    }

    required init(from decoder: Decoder) throws {

        let timeslotContainer = try decoder.container(keyedBy: CodingKeys.self)
        timeslot = try timeslotContainer.decode(String.self, forKey: .timeslot)

        let volunteerListContainer = try decoder.container(keyedBy: CodingKeys.self)
        volunteerList = try volunteerListContainer.decode([String].self, forKey: .volunteerList)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(timeslot, forKey: .timeslot)
        try container.encode(volunteerList, forKey: .volunteerList)
    }

}
