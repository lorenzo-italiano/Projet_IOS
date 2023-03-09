//
// Created by Lorenzo Italiano on 16/02/2023.
//

import SwiftUI

struct TrackItemView: View{

    @ObservedObject private var track: TrackViewModel

    init(track: TrackViewModel){
        self.track = track
    }

    var body: some View {
        Text(track.trackName)
        Text(track.collectionName)
    }
}
