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
    @State var categoryName: String = "🛠"
    @State var city: String = "all"
    @State var isLoading: Bool = true
    @State var subcategory: String = "all"
    @StateObject var advManager = AdvManager()
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.advManager.workAdvs, id: \.id) { adv in
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
                    self.advManager.getAdvs()
                    self.isLoading = false
                }
            if isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("textColor")))
                    .background(Color(UIColor.systemGroupedBackground).opacity(0.1))
            }
        }
    }
}

