//
//  ServiceSubView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import SwiftUI

struct ServiceSubView: View {
    
    @State var list: [Work] = []
    var category: String
    var barTitle: String = ""
    var menu: String
    
    var body: some View {
        
        List(list) { item in
            HStack {
                NavigationLink(destination: AdvView(work: item)) {
//                    Image(item.updatedAt)
                    Text(putEmoji(category: item.category))
                    VStack {
                        Text(item.createdAt)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(item.category)
                            .font(.caption)
                        HStack {
                            Text("Город:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(item.town)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("Зарплата:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(item.salary)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                
            }
            
        }
        .onAppear {
            JSONParser().getWorkList(fileName: menu) { (list) in
                self.list = list.filter { $0.category == category }
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)

        .toolbar{
                NavigationLink(destination: InformationView()) {
                Text("filter")
            }
        }
    }
    
    func putEmoji(category: String) -> String {
        if category == "Zavod" {
            return "🏭"
        } else if category == "motel" {
            return "🏩"
        }
        return ""
    }
}

struct ServiceSubView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSubView(category: "Zavod", menu: "work")
    }
}

#if DEBUG
let example1 = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111")
#endif
