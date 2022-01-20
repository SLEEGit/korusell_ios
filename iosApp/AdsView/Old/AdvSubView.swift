//
//  AdvSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/03.
//

import SwiftUI

struct AdvSubView: View {
    @StateObject private var session = DB()
    @State var list: [Adv] = []
    @State var afterCatlList: [Adv] = []
    @State private var image = UIImage(named: "blank")!
    @State var city : String = "Все города"
    var category: String
    var barTitle: String = ""
    
    
    var body: some View {
        List(list) { item in
            NavigationLink(destination: AdvDetailsView(adv: item)) {
                ExpandedAdv(adv: item, image: image)
            }
        }
        .onAppear {
            globalCategory = category
            city = globalCity
            self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Menu {
                Button("Все города") {
                    globalCity = "Все города"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Сувон") {
                    globalCity = "Сувон"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
            Button("Чхонджу") {
                globalCity = "Чхонджу"
                self.city = globalCity
                self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
            }
                Button("Другой город") {
                    globalCity = "Другой город"
                    self.city = globalCity
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
            } label: {
                Text(city)
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



