//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation


class VolunteerList: ObservableObject {

    @Published public var volunteerList: [Volunteer]{
        didSet{
            state = .ready
        }
    }

    @Published var state : VolunteerListState = .empty {
        didSet{
            if case .loaded(let data) = state {
                volunteerList = data
                state = .ready
            }
        }
    }

    init(volunteerList: [Volunteer]) {
        self.volunteerList = volunteerList
    }

    init(){
        self.volunteerList = [Volunteer]()
    }

}
