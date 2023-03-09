//
// Created by Lorenzo Italiano on 13/02/2023.
//

import SwiftUI

struct TrackListView: View {

    @StateObject public var trackListViewModel: TrackListViewModel

    var body: some View {
        NavigationStack {
            VStack{
                List {

                    ForEach(trackListViewModel.trackModelViewList, id: \.self) { track in
                        NavigationLink(destination: TrackDetailView(track: track)){
                            TrackItemView(track: track)
                        }
                    }
                            .onDelete {
                                indexSet in
                                trackListViewModel.trackModelViewList.remove(atOffsets: indexSet)
                            }
                            .onMove {
                                indexSet, index in
                                trackListViewModel.trackModelViewList.move(fromOffsets: indexSet, toOffset: index)
                            }
                }
                Spacer()
                EditButton()
            }
        }
    }

}
