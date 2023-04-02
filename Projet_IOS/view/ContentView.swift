//
//  ContentView.swift
//  ExercicesMobiles_Listes
//
//  Created by Lorenzo Italiano on 07/02/2023.
//
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tabController = TabController()

//    @StateObject var timeslotList : TimeslotList = TimeslotList(timeslotList: [])
    @StateObject var festivalList : FestivalList = FestivalList(festivalList: [])
//    @StateObject var volunteerList : VolunteerList = VolunteerList(volunteerList: [])

//    @State private var tabSelection = 1

    @AppStorage("token") var token: String = ""

    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
                .tag(Tab.home)
//            TimeslotListView(timeslotList: timeslotList)
//                .tabItem {
//                    Image(systemName: "gamecontroller.fill")
//                    Text("Créneaux")
//                }
//                .tag(2)
//                .isVisible(false)
//            VolunteerListView(volunteerList: volunteerList)
//                .tabItem {
//                    Image(systemName: "gamecontroller.fill")
//                    Text("Bénévoles")
//                }
//                .tag(3)
//                .isVisible(false)
            FestivalListView(festivalList: festivalList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Festivals")
                }
                .tag(Tab.festivals)
            LoginView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Connexion")
                }
                .tag(Tab.login)
                .isVisible(token == "")
            SignUpView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Inscription")
                }
                .tag(Tab.signup)
                .isVisible(token == "")
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .tag(Tab.profile)
                .isVisible(token != "")
        }
        .environmentObject(tabController)
    }
}
