//
//  VolunteerListView.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import SwiftUI

struct VolunteerListView: View {

    @ObservedObject public var volunteerList: VolunteerList
    
    @State private var intent : VolunteerListIntent
    
    init(volunteerList: VolunteerList) {
        self.volunteerList = volunteerList
        self.intent = VolunteerListIntent(model: self._volunteerList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = volunteerList.state{
                ProgressView()
            }
            else{
                NavigationStack {
                    VStack{
                        List {
                            ForEach(volunteerList.volunteerList, id: \.self) { volunteer in
                                NavigationLink(destination: VolunteerDetailView(volunteer: volunteer)){
                                    VolunteerItemView(volunteer: volunteer)
                                }
                            }
                            .onDelete {
                                indexSet in
                                volunteerList.volunteerList.remove(atOffsets: indexSet)
                            }
                            
                        }
                        .refreshable {
                            Task {
                                await self.intent.load()
                            }
                        }
                    }
                }
                .onAppear{
                    switch volunteerList.state{
                    case .empty:
                        Task{
                            await self.intent.load()
                        }
                    default:
                        break
                    }
                }
            }
        }
    }

}
