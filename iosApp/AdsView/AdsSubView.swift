//
//  MainView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/29.
//

import SwiftUI

struct AdsSubView: View {
    
    @State var list: [Work] = []
    @State var unsortedList: [Work] = []
    var category: String
    var barTitle: String = ""
    var menu: String
    @State private var showingSheet = false
    @State private var city = "Все города"
    
    var body: some View {
        List(list) { item in
            let icon = Util().parseCategory(category: item.category)[0]
            let name = Util().parseCategory(category: item.category)[1]
            let date = Util().formatDate(date: item.createdAt)
//                NavigationLink(destination: AdvView(work: item)) {
                Button(action: {
                    showingSheet.toggle()
                }) {
                    HStack {
                    Text(icon)
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.title2)
                        Text(item.salary + " W")
                            .font(.title3)
                            .foregroundColor(.gray)
                        HStack {
                            Text("Город:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(item.town)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        HStack {
                            Text("Добавлено:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showingSheet, content: {
                        AdvView(work: item)
                    })
                
            }
            }
        }
        .onAppear {
            JSONParser().getWorkList(fileName: menu) { (list) in
                self.list = list.filter { $0.category == category }
                self.unsortedList = self.list
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
//                NavigationLink(destination: InformationView()) {
            Menu {
                Button {
                    self.list = self.unsortedList
                    city = "Все города"
                } label: {
                    Text("Все города")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Чхонджу"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Чхонджу")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Хвасонг"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Хвасонг")
                }
            } label: {
//                Image(systemName: "eye.circle")
                 Text(city)
            }
//            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AdsSubView(category: "Zavod", menu: "work")
    }
}

#if DEBUG
let example = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111")
#endif



                            
