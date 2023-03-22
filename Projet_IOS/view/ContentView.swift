//
//  ContentView.swift
//  ExercicesMobiles_Listes
//
//  Created by Lorenzo Italiano on 07/02/2023.
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var timeslotList : TimeslotList = TimeslotList(timeslotList: [])
    @StateObject var volunteerList : VolunteerList = VolunteerList(volunteerList: [])

    @State private var tabSelection = 1

    @AppStorage("token") var token: String = ""

    var body: some View {
        TabView(selection: $tabSelection) {
            Text("The content of the first view")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
                .tag(1)
            TimeslotListView(timeslotList: timeslotList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Créneaux")
                }
                .tag(2)
            VolunteerListView(volunteerList: volunteerList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Bénévoles")
                }
                .tag(3)
            LoginView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Connexion")
                }
                .tag(4)
                .isVisible(token == "")
            SignUpView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Inscription")
                }
                .tag(5)
                .isVisible(token == "")
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .tag(6)
                .isVisible(token != "")
        }
    }
}
