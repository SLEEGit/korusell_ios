//
//  ContentView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI

var globalServices: [Service] = []
var imageList: [RemoteImage] = []
var globalCity: String = "Все города"


struct ContentView: View {
    
    @StateObject private var session = Session()
    
    var body: some View {
        TabView {
            ServiceMenuView()
                .tabItem {
                    Image(systemName: "house")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            Profile(person: person)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
        .onAppear {
            session.fetchData(category: "all") { (list) in
                globalServices = list
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

let person: Person = Person(_id: "ds", avatar: "avatar", name: "John Legend", username: "username", email: "email@email.com", phone: "010 0000 0000")
