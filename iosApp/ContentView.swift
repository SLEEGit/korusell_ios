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
            AdsView()
                .tabItem {
                    Image(systemName: "line.3.horizontal.circle")
                }
            ServiceView()
                .tabItem {
                    Image(systemName: "house")
                }
            Text("😇Здесь будет персональная страничка")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
