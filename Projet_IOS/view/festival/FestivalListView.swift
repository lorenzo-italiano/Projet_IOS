//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListView: View {

    @ObservedObject public var festivalList: FestivalList

    @AppStorage("token") var token: String = ""

    @State private var intent : FestivalListIntent

    @State private var showingAlert = false
    @State private var alertMessage: String = ""


    init(festivalList: FestivalList) {
        self.festivalList = festivalList
        self.intent = FestivalListIntent(model: self._festivalList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = festivalList.state {
                ProgressView()
            }
            else{
                NavigationStack {
                    VStack{
                        Text("Liste des festivals")
                                .font(.title)
                        List {
                            ForEach(festivalList.festivalList, id: \.self) { festival in
                                NavigationLink(destination: FestivalDetailView(festival: festival)){
                                    FestivalItemView(festival: festival)
                                }
                            }
                            .onDelete {
                                indexSet in
                                for index in indexSet{
                                    Task{
                                        do{
                                            try await self.intent.delete(id: self.festivalList.festivalList[index].id ?? "")
                                            showingAlert = true
                                            alertMessage = "Vous avez supprimé un festival !"
                                            festivalList.festivalList.remove(atOffsets: indexSet)
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
                            .deleteDisabled(!JWTDecoder.isUserAdmin(jwtToken: token))
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
                        NavigationLink(destination: FestivalCreationView(intent: intent)){
                            Text("Créer un festival")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.all)
                    }
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .onAppear{
                    if case .empty = festivalList.state{
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
