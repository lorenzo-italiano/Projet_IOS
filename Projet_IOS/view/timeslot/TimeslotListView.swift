//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

import SwiftUI

struct TimeslotListView: View {

    @ObservedObject public var timeslotList: TimeslotList

    @State private var intent : TimeslotListIntent

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    init(timeslotList: TimeslotList) {
        self.timeslotList = timeslotList
        self.intent = TimeslotListIntent(model: self._timeslotList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = timeslotList.state {
                ProgressView()
            }
            else{
                NavigationStack {
                    VStack{
                        List {
                            ForEach(timeslotList.timeslotList, id: \.self) { timeslot in
                                NavigationLink(destination: TimeslotDetailView(timeslot: timeslot)){
                                    TimeslotItemView(timeslot: timeslot)
                                }
                            }
//                            .onDelete {
//                                indexSet in
//                                for index in indexSet{
//                                    Task{
//                                        do{
//                                            try await self.intent.delete(id: self.gameList.gameList[index].id ?? "")
//                                            try await self.intent.load()
//                                            showingAlert = true
//                                            alertMessage = "Vous avez supprimé un jeu !"
//                                        }
//                                        catch RequestError.unauthorized{
//                                            showingAlert = true
//                                            alertMessage = RequestError.unauthorized.description
//                                        }
//                                        catch RequestError.serverError{
//                                            showingAlert = true
//                                            alertMessage = RequestError.serverError.description
//                                        }
//                                    }
//
//                                }
//                            }
                        }
                        .refreshable {
                            Task{
                                do{
                                    try await self.intent.load()
                                }
                                catch RequestError.serverError{
                                    showingAlert = true
                                    alertMessage = RequestError.serverError.description
                                }
                            }
                        }
//                        Button("Create Game"){
//                            print("button pressed")
//                            Task{
//                                do{
//                                    try await self.intent.createGame()
//                                    try await self.intent.load()
//                                    showingAlert = true
//                                    alertMessage = "Vous avez créé un nouveau jeu !"
//                                }
//                                catch RequestError.unauthorized{
//                                    showingAlert = true
//                                    alertMessage = RequestError.unauthorized.description
//                                }
//                                catch RequestError.serverError{
//                                    showingAlert = true
//                                    alertMessage = RequestError.serverError.description
//                                }
//                                catch RequestError.alreadyExists{
//                                    showingAlert = true
//                                    alertMessage = RequestError.alreadyExists.description
//                                }
//                                catch RequestError.badRequest{
//                                    showingAlert = true
//                                    alertMessage = RequestError.badRequest.description
//                                }
//                            }
//                        }
                    }
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .onAppear{
                    if case .empty = timeslotList.state{
                        Task{
                            do{
                                try await self.intent.load()
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
