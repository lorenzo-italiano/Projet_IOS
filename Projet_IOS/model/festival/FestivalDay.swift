//
// Created by Lorenzo Italiano on 25/03/2023.
//

import Foundation

class FestivalDay: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: FestivalDay, rhs: FestivalDay) -> Bool {
        return lhs.startDate == rhs.startDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(startDate)
    }

    @Published var startDate : String
    @Published var endDate : String

    init(startDate : String, endDate : String) {
        self.startDate = startDate
        self.endDate = endDate
    }

    private enum CodingKeys: String, CodingKey {
        case startDate = "startDate"
        case endDate = "endDate"

    }

    required init(from decoder: Decoder) throws {

        let startDateContainer = try decoder.container(keyedBy: CodingKeys.self)
        startDate = try startDateContainer.decode(String.self, forKey: .startDate)

        let endDateContainer = try decoder.container(keyedBy: CodingKeys.self)
        endDate = try endDateContainer.decode(String.self, forKey: .endDate)

    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
    }

}

