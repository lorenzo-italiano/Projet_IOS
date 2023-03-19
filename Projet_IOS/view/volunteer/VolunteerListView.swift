//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

import SwiftUI

struct VolunteerListView: View {

    @ObservedObject public var volunteerList: VolunteerList

    @State private var intent : VolunteerListIntent

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

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
                                for index in indexSet{
                                    Task{
                                        do{
                                            try await self.intent.delete(id: self.volunteerList.volunteerList[index].id ?? "")
                                            showingAlert = true
                                            alertMessage = "Vous avez supprimé un bénévole !"
                                            try await self.intent.getAll()
                                        }
                                        catch RequestError.unauthorized{
                                            showingAlert = true
                                            alertMessage = RequestError.unauthorized.description
                                        }
                                        catch RequestError.serverError{
                                            showingAlert = true
                                            alertMessage = RequestError.serverError.description
                                        }
                                    }

                                }
                            }
                        }
                        .refreshable {
                            Task{
                                do{
                                    try await self.intent.getAll()
                                }
                                catch RequestError.serverError{
                                    showingAlert = true
                                    alertMessage = RequestError.serverError.description
                                }
                            }
                        }
                    }
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .onAppear{
                    if case .empty = volunteerList.state{
                        Task{
                            do{
                                try await self.intent.getAll()
                            }
                            catch RequestError.serverError{
                                showingAlert = true
                                alertMessage = RequestError.serverError.description
                            }
                        }
                    }
                }
            }
        }
    }

}