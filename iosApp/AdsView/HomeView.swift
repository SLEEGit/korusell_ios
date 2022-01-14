//
//  HomeView.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/12.
//

import SwiftUI
import FirebaseAuth

var globalAdv: [Adv] = []
var globalAdvCategory: String = "all"

struct HomeView: View {
    @StateObject private var session = DB()
    @State var list: [Adv] = []
    @State var categoryName: String = "🗂"
    @State var email: String = ""
    @State var city: String = "all"
    @State var isLoading: Bool = true
    @State var emoji: String = "🗂"
    @State var category: String = "all"
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(self.list, id: \.id) { adv in
                        NavigationLink(destination: AdvDetailsView(adv: adv)) {
                            PostView(post: adv)
                        }
                    }
                }
                .navigationTitle("Объявления")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Menu {
                            Group {
                                Button("🗂 Все категории") {
                                    self.categoryName = "🗂"
                                    self.category = "all"
                                    self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                                }
                                Button("🛠 Работа") {
                                    self.categoryName = "🛠"
                                    self.category = "work"
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
                                Button("🥷 Другое") {
                                    self.categoryName = "🥷"
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
                    email = Auth.auth().currentUser?.email ?? ""
                    
                    session.getAdvs(category: "all") { (list) in
                        globalAdv = list.sorted { $0.createdAt > $1.createdAt }
                        print(globalAdv)
                        self.city = globalCity
                        self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                        print(self.list)
                        self.isLoading = false
                    }
                }
            }.disabled(isLoading)
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PostView: View {
    let post: Adv
    
    var body: some View {
        HStack(alignment: .top) {
            UrlImageView(urlString: post.uid  + "ADV" + "0", directory: "advImages")
                .frame(width: 150, height: 150)
            VStack(alignment: .leading) {
                Text(Util().formatDate(date: post.createdAt))
                    .padding(.leading, 16).padding(.bottom, 5)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(post.name)
                    .lineLimit(5)
                    .font(.headline)
                //                    .font(.system(size: 15))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 4)
                Text(post.description)
                    .lineLimit(5)
                    .font(.caption)
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 4)
            }.frame(height: 150, alignment: .leading)
        }
    }
    
    //        var body: some View {
    //            VStack(alignment: .leading, spacing: 8) {
    //                UrlImageView(urlString: post.uid + "0", directory: "advImages")
    //                    .frame(height: 250)
    ////                    .scaledToFit()
    //
    ////                    .clipped()
    //                Text(Util().formatDate(date: post.createdAt))
    //                    .padding(.leading, 16).padding(.bottom, 5)
    //                    .font(.caption)
    //                    .foregroundColor(Color.gray)
    //                HStack {
    //                    Text(post.name).font(.headline)
    //                }
    //                .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
    //
    //                Text(post.description)
    //                    .lineLimit(3)
    //                    .font(.system(size: 15))
    //                    .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 16)
    //            }
    //            .listRowInsets(EdgeInsets())
    //        }
}
