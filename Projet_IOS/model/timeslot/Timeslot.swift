//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class Timeslot: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: Timeslot, rhs: Timeslot) -> Bool {
        return lhs.id == rhs.id && lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate && lhs.volunteerList == rhs.volunteerList
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Published var id: String
    @Published var startDate : String
    @Published var endDate : String
//    @Published var volunteerList : [Volunteer]
    @Published var volunteerList : [String]

    init(id: String, startDate: String, endDate: String, volunteerList: [String]) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.volunteerList = volunteerList
    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate = "startDate"
        case endDate = "endDate"
        case volunteerList = "volunteerList"
    }

    required init(from decoder: Decoder) throws {

        let IDContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try IDContainer.decode(String.self, forKey: .id)

        let startDateContainer = try decoder.container(keyedBy: CodingKeys.self)
        startDate = try startDateContainer.decode(String.self, forKey: .startDate)

        let endDateContainer = try decoder.container(keyedBy: CodingKeys.self)
        endDate = try endDateContainer.decode(String.self, forKey: .endDate)

        let volunteerListContainer = try decoder.container(keyedBy: CodingKeys.self)
        volunteerList = try volunteerListContainer.decode([String].self, forKey: .volunteerList)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(volunteerList, forKey: .volunteerList)
    }

}