//
//  MainView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/11/29.
//

import SwiftUI

struct AdsSubView: View {
    
    @State var list: [Work] = []
    
    var category: String
    var barTitle: String = ""
    var menu: String
    @State var unsortedList: [Work] = []
    @State private var showingSheet = false
    @State private var city = "Все города"
    
    var body: some View {
        List(list) { item in
            let icon = Util().parseCategory(category: item.category)[0]
            let name = Util().parseCategory(category: item.category)[1]
            let date = Util().formatDate(date: item.createdAt)
            NavigationLink(destination: AdvView(work: item)) {
                HStack {
                    Text(icon)
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.title2)
                        Text(item.salary + " \u{20A9}")
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
                }
            }
        }
        .onAppear {
            JSONParser().getWorkList(fileName: menu) { (list) in
                
                if category != "work" {
                    self.unsortedList = list.filter { $0.category == category }
                    self.list = list.filter { $0.category == category }
                } else {
                    self.unsortedList = list
                    self.list = list
                }
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Menu {
                Button {
                    self.list = self.unsortedList
                    city = "Все города"
                } label: {
                    Text("Все города")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Ансан"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Ансан")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Хвасонг"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Хвасонг")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Инчхон"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Инчхон")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Сеул"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Сеул")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Асан-Синчанг"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Асан-Синчанг")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Чхонан"
                    self.list = list.filter { $0.town == city }
                } label: {
                    Text("Чхонан")
                }
                Button {
                    self.list = self.unsortedList
                    city = "Другой город"
                    self.list = list.filter { $0.town != "Чхонан" && $0.town != "Хвасонг" && $0.town != "Ансан" && $0.town != "Асан-Синчанг" && $0.town != "Сеул" && $0.town != "Инчхон" && $0.town != "Хвасонг"}
                } label: {
                    Text("Другой город")
                }
            } label: {
                //                Image(systemName: "eye.circle")
                Text(city)
            }
        }
    }
    
}

struct AdsSubView_Previews: PreviewProvider {
    static var previews: some View {
        AdsSubView(category: "Zavod", menu: "work")
    }
}

#if DEBUG
let example = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", visa: ["F4", "H2"], town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111", image: "factory")
#endif




