//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class TimeslotVolunteerAssociation: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: TimeslotVolunteerAssociation, rhs: TimeslotVolunteerAssociation) -> Bool {
        return lhs.timeslot.id == rhs.timeslot.id && lhs.volunteerList == rhs.volunteerList
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(timeslot.id)
    }

    @Published var timeslot : Timeslot
    @Published var volunteerList : [Volunteer]

    init(timeslot: Timeslot, volunteerList: [Volunteer]) {
        self.timeslot = timeslot
        self.volunteerList = volunteerList
    }

    private enum CodingKeys: String, CodingKey {
        case timeslot = "timeslot"
        case volunteerList = "volunteerList"
    }

    required init(from decoder: Decoder) throws {

        let timeslotContainer = try decoder.container(keyedBy: CodingKeys.self)
        timeslot = try timeslotContainer.decode(Timeslot.self, forKey: .timeslot)

        let volunteerListContainer = try decoder.container(keyedBy: CodingKeys.self)
        volunteerList = try volunteerListContainer.decode([Volunteer].self, forKey: .volunteerList)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(timeslot, forKey: .timeslot)
        try container.encode(volunteerList, forKey: .volunteerList)
    }

}
