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
    @State var category: String = "all"
    @State var categoryName: String = "Категории"
    @State var email: String = ""
    @State var city: String = "all"
    @Environment(\.colorScheme) var colorScheme
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    ForEach(self.list, id: \.id) { adv in
                        NavigationLink(destination: AdvDetailsView(adv: adv)) {
                            PostView(post: adv, screenWidth: geometry.size.width)
                        }
                        
                    }
                }
                
            }.navigationTitle("Объявления")
                .navigationBarItems(leading:
                                        NavigationLink(destination: getDestination()) {
                    if colorScheme == .dark {
                        Image("logo_blue_line")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 20)
                    } else {
                        Image("logo_blue_line")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 20)
                            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                    }
                    
                })
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu(globalCity) {
                            Button("Все") {
                                globalCity = "Все"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Ансан") {
                                globalCity = "Ансан"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Хвасонг") {
                                globalCity = "Хвасонг"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Инчхон") {
                                globalCity = "Инчхон"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Сеул") {
                                globalCity = "Сеул"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Асан") {
                                globalCity = "Асан"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Чхонан") {
                                globalCity = "Чхонан"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Другой город") {
                                globalCity = "Другой город"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                        }
                        Menu(categoryName) {
                            Button("Все категории") {
                                globalAdvCategory = "all"
                                self.categoryName = "Все категории"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Работа") {
                                globalAdvCategory = "work"
                                self.categoryName = "Работа"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Транспорт") {
                                globalAdvCategory = "transport"
                                self.categoryName = "Транспорт"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Недвижимость") {
                                globalAdvCategory = "house"
                                self.categoryName = "Недвижимость"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Телефоны и Аксессуары") {
                                globalAdvCategory = "phone"
                                self.categoryName = "Телефоны и Аксессуары"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Button("Для дома, хобби") {
                                globalAdvCategory = "hobby"
                                self.categoryName = "Для дома, хобби"
                                self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                            }
                            Group {
                                Button("Автозапчасти и Аксессуары") {
                                    globalAdvCategory = "car"
                                    self.categoryName = "Автозапчасти и Аксессуары"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Электроника") {
                                    globalAdvCategory = "electronic"
                                    self.categoryName = "Электроника"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Детские товары") {
                                    globalAdvCategory = "children"
                                    self.categoryName = "Детские товары"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Одежда") {
                                    globalAdvCategory = "clothes"
                                    self.categoryName = "Одежда"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Спорт, туризм и отдых") {
                                    globalAdvCategory = "sport"
                                    self.categoryName = "Спорт, туризм и отдых"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Домашние животные") {
                                    globalAdvCategory = "pet"
                                    self.categoryName = "Домашние животные"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                                Button("Обмен, отдам бесплатно") {
                                    globalAdvCategory = "change"
                                    self.categoryName = "Обмен, отдам бесплатно"
                                    self.list = Util().filterAdv(city: globalCity, category: globalAdvCategory, unsortedList: globalAdv)
                                }
                            }
                        }
                    }
                }
        }.onAppear {
            email = Auth.auth().currentUser?.email ?? ""
            
            city = globalCity
            session.getAdvs(category: "all") { (list) in
                globalAdv = list.sorted { $0.createdAt > $1.createdAt }
                print(globalAdv)
                self.list = Util().filterAdv(city: city, category: category, unsortedList: globalAdv)
                print(self.list)
                self.isLoading = false
            }
            
        }
    }
    func getDestination() -> AnyView {
        if email == "guagetru.bla@inbox.ru" {
            return AnyView(AdminPanelView())
        } else {
            return AnyView(Text("🥚 ver. 1.2"))
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
    let screenWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 8) {
            UrlImageView(urlString: post.uid + "0", directory: "advImages")
                .frame(width: 100, height: 100)
            VStack {
                Text(post.createdAt)
                    .padding(.leading, 16).padding(.bottom, 5)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(post.name)
                    .lineLimit(5)
                    .font(.headline)
                //                    .font(.system(size: 15))
                    .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 4)
            }.padding(.top, 10)
        }
    }
    
    //    var body: some View {
    //        VStack(alignment: .leading, spacing: 8) {
    //            HStack {
    //                // cacheable image
    //                Image(post.image)
    //                    .resizable()
    //                    .clipShape(Circle())
    //                    .frame(width: 50, height: 50)
    //                Text(post.name).font(.headline)
    //            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
    //            // cacheable image
    //            Image(post.image)
    //                .resizable()
    //                .scaledToFill()
    //                .frame(width: screenWidth, height: 250)
    //                .clipped()
    //            Text(post.created)
    //                .padding(.leading, 16).padding(.bottom, 5)
    //                .font(.caption)
    //                .foregroundColor(Color.gray)
    //            Text(post.text)
    //                .lineLimit(nil)
    //                .font(.system(size: 15))
    //                .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 16)
    //        }.listRowInsets(EdgeInsets())
    //    }
}
