//
//  HomeView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/12.
//

import SwiftUI
import FirebaseAuth

//var globalAdv: [Adv] = []
var globalAdvCategory: String = "all"

struct HomeView: View {
    var body: some View {
        NavigationView {
            AdvList()
                .navigationBarTitle("Объявления")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PostView: View {
    let adv: Adv
    //    @State var width: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .top) {
            UrlImageView(urlString: adv.uid  + "ADV" + "0", directory: "advImages")
                .scaledToFit()
                .frame(width: 150, height: 130)
            VStack(alignment: .leading) {
                Text(Util().formatDate(date: adv.createdAt))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 3).padding(.top, 2)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(adv.name)
                    .lineLimit(2)
                    .font(.headline)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.city)
                    .foregroundColor(Color.gray)
                    .lineLimit(5)
                    .font(.caption)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
                Text(adv.price)
                    .font(.title3)
                Spacer()
                
            }.frame(height: 150, alignment: .leading)
        }.frame(alignment: .top)
            .onAppear {
            }
    }
}

struct AdvList: View {
    @StateObject private var session = DB()
    @State var list: [Adv] = []
    @State var categoryName: String = "🗂"
    @State var city: String = "all"
    @State var isLoading: Bool = true
    @StateObject var advManager = AdvManager()

    
    var body: some View {
        ZStack {
            List {
                ForEach(self.advManager.advs, id: \.uid) { adv in
//                    ForEach(self.advManager.openAdv.sorted { $0.createdAt > $1.createdAt }, id: \.uid) { adv in
                    NavigationLink(destination: AdvDetailsView(adv: adv)) {
                        PostView(adv: adv)
                    }
                }
            }.disabled(isLoading)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Menu {
                            Group {
                                Button("🗂 Все категории") {
                                    self.categoryName = "🗂"
                                    self.advManager.category = "all"
                                    self.advManager.getAdvs()
                                }
                                Button("🚗 Транспорт") {
                                    self.categoryName = "🚗"
                                    self.advManager.category = "transport"
                                    self.advManager.getAdvs()
                                }
                                Button("🏢 Недвижимость") {
                                    self.categoryName = "🏢"
                                    self.advManager.category = "house"
                                    self.advManager.getAdvs()
                                }
                                Button("📱 Телефоны и Аксессуары") {
                                    self.categoryName = "📱"
                                    self.advManager.category = "phone"
                                    self.advManager.getAdvs()
                                }
                                Button("🏠 Для дома, хобби") {
                                    self.categoryName = "🏠"
                                    self.advManager.category = "hobby"
                                    self.advManager.getAdvs()
                                }
                                Button("⚙️ Автозапчасти и Аксессуары") {
                                    self.categoryName = "⚙️"
                                    self.advManager.category = "car"
                                    self.advManager.getAdvs()
                                }
                                Button("📺 Электроника") {
                                    self.categoryName = "📺"
                                    self.advManager.category = "electronic"
                                    self.advManager.getAdvs()
                                }
                                Button("👶🏻 Детские товары") {
                                    self.categoryName = "👶🏻"
                                    self.advManager.category = "children"
                                    self.advManager.getAdvs()
                                }
                                Button("👕 Одежда") {
                                    self.categoryName = "👕"
                                    self.advManager.category = "clothes"
                                    self.advManager.getAdvs()
                                }
                            }
                            Group {
                                Button("🏓 Спорт, туризм и отдых") {
                                    self.categoryName = "🏓"
                                    self.advManager.category = "sport"
                                    self.advManager.getAdvs()
                                }
                                Button("🐶 Домашние животные") {
                                    self.categoryName = "🐶"
                                    self.advManager.category = "pet"
                                    self.advManager.getAdvs()
                                }
                                Button("🔄 Обмен, отдам бесплатно") {
                                    self.categoryName = "🔄"
                                    self.advManager.category = "change"
                                    self.advManager.getAdvs()
                                }
                                Button("🪆 Другое") {
                                    self.categoryName = "🪆"
                                    self.advManager.category = "other"
                                    self.advManager.getAdvs()
                                }
                            }.padding()
                        } label: {
                            Text(self.categoryName)
                                .font(.system(size: 25))
                        }
                        
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        
                        Menu {
                            Button("Все города") {
                                globalCity = "Все города"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Ансан") {
                                globalCity = "Ансан"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Хвасонг") {
                                globalCity = "Хвасонг"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Инчхон") {
                                globalCity = "Инчхон"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Сеул") {
                                globalCity = "Сеул"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Сувон") {
                                globalCity = "Сувон"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Асан") {
                                globalCity = "Асан"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Чхонан") {
                                globalCity = "Чхонан"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Чхонджу") {
                                globalCity = "Чхонджу"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                            Button("Другой город") {
                                globalCity = "Другой город"
                                self.advManager.city = globalCity
                                self.advManager.getAdvs()
                            }
                        } label: {
                            HStack {
                                Text(globalCity)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                }
                .onAppear {
                    self.city = globalCity
                    DB().getAdvs(category: "all") { list in
                        globalAdv = list
                        //                включен/выключен фильтр
                            .filter { $0.isActive == "1" }
                            .sorted { $0.createdAt > $1.createdAt }
                        
                        // filter for search
                        //                        .filter { $0.name.lowercased().contains("iphone") }
                        
//                        self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                        self.isLoading = false
                    }
                }
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
    }
}
