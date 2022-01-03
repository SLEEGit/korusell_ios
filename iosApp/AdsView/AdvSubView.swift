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
            self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Menu(globalCity) {
                Button("Все города") {
                    globalCity = "Все города"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Ансан") {
                    globalCity = "Ансан"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Хвасонг") {
                    globalCity = "Хвасонг"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Инчхон") {
                    globalCity = "Инчхон"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Сеул") {
                    globalCity = "Сеул"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Асан") {
                    globalCity = "Асан"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Чхонан") {
                    globalCity = "Чхонан"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
                Button("Другой город") {
                    globalCity = "Другой город"
                    self.list = Util().filterAdv(city: globalCity, category: category, unsortedList: globalAdv)
                }
            }
        }
    }
    
}

//struct ServiceSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceSubView(category: "food", menu: "service")
//    }
//}



