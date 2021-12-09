//
//  ContentView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
<<<<<<< HEAD
=======
            AdsView()
                .tabItem {
                    Image(systemName: "line.3.horizontal.circle")
                    Text("Объявления")
                        
                }
>>>>>>> 49679bc382012bc8a46535c15c3876c16ef7f428
            ServiceView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Услуги")
                }
            Text("Map")
                .tabItem {
                    Image(systemName: "map")
                }
            Profile(person: person)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Профиль")
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
