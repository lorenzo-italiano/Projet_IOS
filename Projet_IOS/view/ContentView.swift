//
//  ContentView.swift
//  ExercicesMobiles_Listes
//
//  Created by Lorenzo Italiano on 07/02/2023.
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var gameList : GameList = GameList(gameList: [])
    
    @StateObject var volunteerList : VolunteerList = VolunteerList(volunteerList: [])
    @StateObject var trackListViewModel = TrackListViewModel(trackModelList: TrackDTO.dtoToArray(dtoArray: JsonHelper.loadFromFile(name: "test", extensionName: "json") ?? []))

    var body: some View {
        TabView {
           Text("The content of the first view")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
            GameListView(gameList: gameList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Jeux")
                }
            VolunteerListView(volunteerList: volunteerList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Bénévoles")
                }
            TrackListView(trackListViewModel: trackListViewModel)
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Tracks")
                }
        }
    }
}
