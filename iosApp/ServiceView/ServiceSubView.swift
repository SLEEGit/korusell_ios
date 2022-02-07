//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI 

struct ServiceSubView: View {

    @StateObject var serviceManager = ServiceManager()
    @State var afterCatlList: [Service] = []
    @State private var image = UIImage(named: "blank")!
    var category: String
    var barTitle: String = ""
    @State var city: String = "Все города"
    
    var body: some View {
        List {
            ForEach(serviceManager.services, id: \.name) { service in
                NavigationLink(destination: ServiceView(service: service)) {
                    ExpandedService(service: service, image: image)
                }
            }
        }
        .onAppear {
            globalCategory = category
            self.city = globalCity
            serviceManager.category = category
            serviceManager.city = globalCity
//            serviceManager.getServices()
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Menu {
                Button("Все города") {
                    globalCity = "Все города"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Сувон") {
                    globalCity = "Сувон"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.city = globalCity
                    serviceManager.city = globalCity
                    serviceManager.getServices()
                }
            Button("Чхонджу") {
                globalCity = "Чхонджу"
                self.city = globalCity
                serviceManager.city = globalCity
                serviceManager.getServices()
            }
            Button("Другой город") {
                globalCity = "Другой город"
                self.city = globalCity
                serviceManager.city = globalCity
                serviceManager.getServices()
                }
            } label: {
                Text(self.city)
                .font(.system(size: 15))
                .minimumScaleFactor(0.1)
            }
        )
    }
    
}

struct ExpandedService: View {
    @State var service: Service
    @State var image: UIImage
    var body: some View {
        HStack {
            UrlImageView(urlString: service.uid + "0", directory: "images")
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(service.name)
                    .font(.system(size: 15))
                    .bold()
                    .minimumScaleFactor(0.1)
                HStack {
                    Text("Город:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text(service.city)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Text(service.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    .lineLimit(3)
            }
            Spacer()
        }
    }
}


