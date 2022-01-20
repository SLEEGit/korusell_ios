//
//  WorkView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/20.
//

import SwiftUI
import FirebaseAuth

struct WorkView: View {
    var body: some View {
        NavigationView {
            WorkList()
                .navigationBarTitle("Работа")
        }
    }
}

struct OneWorkView: View {
    let adv: Adv
    //    @State var width: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .top) {
            UrlImageView(urlString: adv.uid  + "ADV" + "0", directory: "advImages")
                .scaledToFit()
                .frame(width: 120, height: 100)
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
                
            }.frame(height: 100, alignment: .leading)
        }.frame(alignment: .top)
            .onAppear {
            }
    }
}

struct WorkList: View {
    @StateObject private var session = DB()
    @State var list: [Adv] = []
    @State var categoryName: String = "🛠"
    @State var city: String = "all"
    @State var isLoading: Bool = true
    @State var subcategory: String = "all"
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.list, id: \.id) { adv in
                    NavigationLink(destination: AdvDetailsView(adv: adv)) {
                        OneWorkView(adv: adv)
                    }
                }
            }.disabled(isLoading)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Menu {
                            Group {                   
                                Button("🛠 Вся Работа") {
                                    self.categoryName = "🛠"
                                    self.subcategory = "all"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("🏭 Завод") {
                                    self.categoryName = "🏭"
                                    self.subcategory = "factory"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("👷🏻‍♀️ Стройка") {
                                    self.categoryName = "👷🏻‍♀️"
                                    self.subcategory = "construction"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("🏩 Мотель") {
                                    self.categoryName = "🏩"
                                    self.subcategory = "motel"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("🍽 Общепит") {
                                    self.categoryName = "🍽"
                                    self.subcategory = "cafe"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("📦 Почта/Доставка") {
                                    self.categoryName = "📦"
                                    self.subcategory = "delivery"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("🧑🏽‍🌾 Сельхоз работы") {
                                    self.categoryName = "🧑🏽‍🌾"
                                    self.subcategory = "farm"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("💼 Работа в офисе") {
                                    self.categoryName = "💼"
                                    self.subcategory = "office"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                                Button("👨‍🚀 Другая работа") {
                                    self.categoryName = "👨‍🚀"
                                    self.subcategory = "otherwork"
                                    self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                                }
                            }
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
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Ансан") {
                                globalCity = "Ансан"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Хвасонг") {
                                globalCity = "Хвасонг"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Инчхон") {
                                globalCity = "Инчхон"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Сеул") {
                                globalCity = "Сеул"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Сувон") {
                                globalCity = "Сувон"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Асан") {
                                globalCity = "Асан"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Чхонан") {
                                globalCity = "Чхонан"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Чхонджу") {
                                globalCity = "Чхонджу"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
                            }
                            Button("Другой город") {
                                globalCity = "Другой город"
                                self.city = globalCity
                                self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
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
                            .filter { $0.isActive == "1"}
                            .sorted { $0.createdAt > $1.createdAt }
                        
                        // filter for search
                        //                        .filter { $0.name.lowercased().contains("iphone") }
                        
                        self.list = Util().filterWork(city: city, subcategory: subcategory, unsortedList: globalAdv)
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

