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
    @State var category: String = "all"
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.list, id: \.id) { adv in
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
                                    self.category = "all"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🚗 Транспорт") {
                                    self.categoryName = "🚗"
                                    self.category = "transport"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🏢 Недвижимость") {
                                    self.categoryName = "🏢"
                                    self.category = "house"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("📱 Телефоны и Аксессуары") {
                                    self.categoryName = "📱"
                                    self.category = "phone"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🏠 Для дома, хобби") {
                                    self.categoryName = "🏠"
                                    self.category = "hobby"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("⚙️ Автозапчасти и Аксессуары") {
                                    self.categoryName = "⚙️"
                                    self.category = "car"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("📺 Электроника") {
                                    self.categoryName = "📺"
                                    self.category = "electronic"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("👶🏻 Детские товары") {
                                    self.categoryName = "👶🏻"
                                    self.category = "children"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("👕 Одежда") {
                                    self.categoryName = "👕"
                                    self.category = "clothes"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                            }
                            Group {
                                Button("🏓 Спорт, туризм и отдых") {
                                    self.categoryName = "🏓"
                                    self.category = "sport"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🐶 Домашние животные") {
                                    self.categoryName = "🐶"
                                    self.category = "pet"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🔄 Обмен, отдам бесплатно") {
                                    self.categoryName = "🔄"
                                    self.category = "change"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🪆 Другое") {
                                    self.categoryName = "🪆"
                                    self.category = "other"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
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
                            HStack {
                                Text(self.city)
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
                        
                        self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
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
