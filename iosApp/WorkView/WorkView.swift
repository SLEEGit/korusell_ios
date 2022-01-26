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
    @State var icon: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Город:")
                    .foregroundColor(Color.gray)
                Text(adv.city)
                    .lineLimit(1)
                    .font(.body)
                Spacer()
                Text(Util().formatDate(date: adv.createdAt))
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }.padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2).padding(.top, 3)
            Text(adv.name)
                .lineLimit(2)
                .font(.headline)
                .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
            Text(adv.price)
                .lineLimit(1)
                .font(.title3)
                .padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 2)
            HStack {
                VStack {
                    Text("")
                        .font(.caption)
                    Text(icon)
                }
                if adv.gender != "" {
                    VStack {
                        Text("Пол")
                            .font(.caption)
                        Text(adv.gender)
                    }
                }
                if adv.shift != "" {
                    VStack {
                        Text("Смена")
                            .font(.caption)
                        Text(adv.shift)
                    }
                }
                if !adv.age.isEmpty {
                    VStack {
                        Text("Возвраст")
                            .font(.caption)
                        Text(adv.age.joined(separator: "-"))
                            .font(.headline)
                    }
                }
                if !adv.visa.isEmpty {
                    VStack {
                        Text("Виза")
                            .font(.caption)
                        Text(adv.visa.joined(separator: ","))
                            .font(.headline)
                    }
                }
                
            }.padding(.leading, 4).padding(.trailing, 4).padding(.bottom, 3)
        }.frame(alignment: .leading)
            .onAppear {
                if adv.subcategory == "factory" {
                    self.icon = "🏭"
                } else if adv.subcategory == "construction" {
                    self.icon = "👷🏻‍♀️"
                } else if adv.subcategory == "motel" {
                    self.icon = "🏩"
                } else if adv.subcategory == "cafe" {
                    self.icon = "🍽"
                } else if adv.subcategory == "farm" {
                    self.icon = "🧑🏽‍🌾"
                } else if adv.subcategory == "delivery" {
                    self.icon = "📦"
                } else if adv.subcategory == "office" {
                    self.icon = "💼"
                } else if adv.subcategory == "otherwork" {
                    self.icon = "👨‍🚀"
                }
            }
    }
}


struct WorkList: View {
    @State var categoryName: String = "🛠"
    @State var city: String = "all"
    @State var isLoading: Bool = true
    @State var subcategory: String = "all"
    @StateObject var advManager = AdvManager()
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.advManager.workAdvs, id: \.id) { adv in
                    NavigationLink(destination: WorkViewDetails(adv: adv)) {
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
                                    self.advManager.subcategory = "all"
                                    self.advManager.getAdvs()
                                }
                                Button("🏭 Завод") {
                                    self.categoryName = "🏭 "
                                    self.advManager.subcategory = "factory"
                                    self.advManager.getAdvs()
                                }
                                Button("👷🏻‍♀️ Стройка") {
                                    self.categoryName = "👷🏻‍♀️"
                                    self.advManager.subcategory = "construction"
                                    self.advManager.getAdvs()
                                }
                                Button("🏩 Мотель") {
                                    self.categoryName = "🏩"
                                    self.advManager.subcategory = "motel"
                                    self.advManager.getAdvs()
                                }
                                Button("🍽 Общепит") {
                                    self.categoryName = "🍽"
                                    self.advManager.subcategory = "cafe"
                                    self.advManager.getAdvs()
                                }
                                Button("📦 Почта/Доставка") {
                                    self.categoryName = "📦"
                                    self.advManager.subcategory = "delivery"
                                    self.advManager.getAdvs()
                                }
                                Button("🧑🏽‍🌾 Сельхоз работы") {
                                    self.categoryName = "🧑🏽‍🌾"
                                    self.advManager.subcategory = "farm"
                                    self.advManager.getAdvs()
                                }
                                Button("💼 Работа в офисе") {
                                    self.categoryName = "💼"
                                    self.advManager.subcategory = "office"
                                    self.advManager.getAdvs()
                                }
                                Button("👨‍🚀 Другая работа") {
                                    self.categoryName = "👨‍🚀"
                                    self.advManager.subcategory = "otherwork"
                                    self.advManager.getAdvs()
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
                    advManager.subcategory = subcategory
                    advManager.city = globalCity
                    //                    self.advManager.getAdvs()
                    self.isLoading = false
                }
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
    }
}



