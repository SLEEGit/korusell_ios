//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI

struct ServiceSubView: View {
    @StateObject private var session = DB()
    @State var list: [Service] = []
    @State var afterCatlList: [Service] = []
    @State private var image = UIImage(named: "blank")!
    var category: String
    var barTitle: String = ""
    
    
    var body: some View {
        List(list) { item in
            NavigationLink(destination: ServiceView(service: item)) {
                ExpandedService(service: item, image: image)
            }
        }
        .onAppear {
            globalCategory = category
            self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Menu {
                Button("Все города") {
                    globalCity = "Все города"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Сувон") {
                    globalCity = "Сувон"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
                Button("Другой город") {
                    globalCity = "Другой город"
                    self.list = Util().filter(city: globalCity, category: category, unsortedList: globalServices)
                }
            } label: {
                Text(globalCity)
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



