//
//  ContentView.swift
//  ExercicesMobiles_Listes
//
//  Created by Lorenzo Italiano on 07/02/2023.
//
//

import SwiftUI

struct ContentView: View {

    //let data: [TrackViewModel]? = JsonHelper.loadFromFile(name: "test", extensionName: "json")

    @StateObject var trackListViewModel = TrackListViewModel(trackModelList: TrackDTO.dtoToArray(dtoArray: JsonHelper.loadFromFile(name: "test", extensionName: "json") ?? []))
    /*@StateObject var trackListViewModel = TrackListViewModel(trackModelList: [
        TrackViewModel(trackName: "That's Life", artistName: "James Brown", collectionName: "Gettin' Down to It", releaseDate: "1969-05-01T12:00:00Z"),
        TrackViewModel(trackName: "Shoot the Moon", artistName: "Norah Jones", collectionName: "Come Away With Me (Deluxe Edition)", releaseDate: "2002-02-26T08:00:00Z"),
        TrackViewModel(trackName: "Kozmic Blues", artistName: "Janis Joplin", collectionName: "I Got Dem Ol' Kozmic Blues Again Mama!", releaseDate: "1969-09-11T07:00:00Z"),
        TrackViewModel(trackName: "You Found Another Lover (I Lost Another Friend)", artistName: "Ben Harper & Charlie Musselwhite", collectionName: "Get Up! (Deluxe Version)", releaseDate: "2013-01-29T12:00:00Z")
    ])*/

    var body: some View {
        TabView {
           Text("The content of the first view")
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("First Tab")
                }
            TrackListView(trackListViewModel: trackListViewModel)
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Tracks")
                }
        }
    }
}
