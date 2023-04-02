//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListView: View {

    @ObservedObject public var zoneList: ZoneList
    @ObservedObject public var festival: Festival

    @State private var intent : ZoneListIntent

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @AppStorage("token") var token: String = ""

    init(zoneList: ZoneList, festival: Festival) {
        self.zoneList = zoneList
        self.festival = festival
        self.intent = ZoneListIntent(model: self._zoneList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = zoneList.state {
                ProgressView()
            }
            else{
                NavigationStack {
                    VStack{
                        List {
                            ForEach(zoneList.zoneList, id: \.self) { zone in
                                NavigationLink(destination: ZoneDetailView(zone: zone, festival: festival)){
                                    Text(zone.name)
//                                    TimeslotItemView(timeslot: timeslot)
                                }
                            }
                            .onDelete {
                                indexSet in
                                for index in indexSet{
                                    Task{
                                        do {
                                            try await self.intent.delete(zone: self.zoneList.zoneList[index] ?? Zone(id: "", name: "", nbVolunteers: 0, timeslotList: []), id: festival.id!)
                                            showingAlert = true
                                            alertMessage = "Vous avez supprimé une zone d'un festival !"
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
                            }.deleteDisabled(!JWTDecoder.isUserAdmin(jwtToken: token))
                        }
                    }
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
    }
}
