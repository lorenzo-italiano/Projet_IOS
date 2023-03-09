//
// Created by Lorenzo Italiano on 07/02/2023.
//

import SwiftUI

class TrackListViewModel: ObservableObject {

    @Published public var trackModelViewList: [TrackViewModel]

    init(trackModelList: [TrackViewModel]) {
        self.trackModelViewList = trackModelList
    }

}
