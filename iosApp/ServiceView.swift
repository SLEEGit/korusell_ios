//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/01.
//

import SwiftUI

struct ServiceView: View {
    @ObservedObject var fetcher = DataFetcher()
    var body: some View {
        NavigationView {
            List(fetcher.serviceItem) { item in
                ZStack {
                    NavigationLink(destination: HomeView(category: item.category, barTitle: item.image + " " + item.name, menu: "service" )) {}
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    HStack{
                        Text(item.image)
                            .font(.title)
                        Text(item.name)
                        Spacer()
                    }
                }
            }.navigationTitle("УСЛУГИ")
                .toolbar{
                        NavigationLink(destination: InformationView()) {
                        Text("info")
                    }
                }
                
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
