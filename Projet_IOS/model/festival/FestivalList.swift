//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class FestivalList: ObservableObject {

    @Published public var festivalList: [Festival] {
        didSet{
            state = .ready
        }
    }

    @Published var state : FestivalState = .empty {
        didSet{
            if case .loaded(let data) = state {
                festivalList = data
                state = .ready
            }
        }
    }

    init(festivalList: [Festival]) {
        self.festivalList = festivalList
    }

    init(){
        self.festivalList = [Festival]()
    }

}
