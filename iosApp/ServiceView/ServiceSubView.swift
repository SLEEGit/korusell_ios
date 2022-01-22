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
    @State var list: [Service] = serviceManager.services
    @State var afterCatlList: [Service] = []
    @State private var image = UIImage(named: "blank")!
    var category: String
    var barTitle: String = ""
    @State var city: String = "Все города"
    
    var body: some View {
        List {
            // Добавить логику для других городов и переходить на объявления с @StateObject чтобы убрать все фетчи после изменений
            ForEach(self.list.filter { self.city == "Все города" ? $0.category == self.category : $0.category == self.category && $0.city == self.city }, id: \.uid) { service in
            NavigationLink(destination: ServiceView(service: service)) {
                ExpandedService(service: service, image: image)
            }
        }
        }
        .onAppear {
            globalCategory = category
            self.city = globalCity
//            self.list = serviceManager.services.filter { $0.category == self.category }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Menu {
                Button("Все города") {
                    globalCity = "Все города"
                    self.city = globalCity
      
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.city = globalCity
      
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.city = globalCity
 
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.city = globalCity
            
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.city = globalCity
           
                }
                Button("Сувон") {
                    globalCity = "Сувон"
                    self.city = globalCity
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.city = globalCity
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.city = globalCity
                }
            Button("Чхонджу") {
                globalCity = "Чхонджу"
                self.city = globalCity
            }
            Button("Другой город") {
                    globalCity = "Другой город"
                self.city = globalCity
                self.list = self.list.filter { $0.category == self.category && $0.city != self.city }
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



