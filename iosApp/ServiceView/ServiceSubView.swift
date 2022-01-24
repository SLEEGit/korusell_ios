//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI 

struct ServiceSubView: View {
//    @StateObject var serviceManager = ServiceManager()
    
    @StateObject private var session = DB()
//    @State var list: [Service] = serviceManager.services
    @StateObject var serviceManager = ServiceManager()
    @State var afterCatlList: [Service] = []
    @State private var image = UIImage(named: "blank")!
    var category: String
    var barTitle: String = ""
    @State var city: String = "Все города"
    
    var body: some View {
        List {
            // Добавить логику для других городов и переходить на объявления с @StateObject чтобы убрать все фетчи после изменений
            ForEach(serviceManager.services, id: \.uid) { service in
                NavigationLink(destination: ServiceView(service: service)) {
                    ExpandedService(service: service, image: image)
                }
            }
        }
        .onAppear {
            globalCategory = category
            self.city = globalCity
            serviceManager.category = category
            serviceManager.getServices()
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

//struct ServiceSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceSubView(category: "food", menu: "service")
//    }
//}



