//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class TimeslotList: ObservableObject {

    @Published public var timeslotList: [Timeslot] {
        didSet {
            state = .ready
        }
    }

    @Published var state : TimeslotState = .empty {
        didSet {
            if case .loaded(let data) = state {
                timeslotList = data
                state = .ready
            }
        }
    }

    init(timeslotList: [Timeslot]) {
        self.timeslotList = timeslotList
    }

    init() {
        self.timeslotList = [Timeslot]()
    }
}
