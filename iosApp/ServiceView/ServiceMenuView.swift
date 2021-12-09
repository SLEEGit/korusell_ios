//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/01.
//

import SwiftUI

struct ServiceMenuView: View {
    @ObservedObject var fetcher = DataFetcher()
    var body: some View {
        NavigationView {
            List(fetcher.serviceItem) { item in
                ZStack {
                    NavigationLink(destination: ServiceSubView(category: item.category, barTitle: item.image + " " + item.name, menu: item.category )) {}
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

struct ServiceMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceMenuView()
    }
}
