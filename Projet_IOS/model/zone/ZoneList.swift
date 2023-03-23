//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class ZoneList: ObservableObject {

    @Published public var zoneList: [Zone]{
        didSet{
            state = .ready
        }
    }

    @Published var state : ZoneState = .empty {
        didSet{
            if case .loaded(let data) = state {
                zoneList = data
                state = .ready
            }
        }
    }

    init(zoneList: [Zone]) {
        self.zoneList = zoneList
    }

    init(){
        self.zoneList = [Zone]()
    }

}