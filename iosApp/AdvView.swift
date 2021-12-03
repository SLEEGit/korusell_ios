//
//  AdvView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/02.
//

import SwiftUI

struct AdvView: View {
    
    var work: Work!
    
    var body: some View {
        ScrollView {
            Image(work.category)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            VStack {
                Text(work.createdAt)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(work.category)
                    .font(.caption)
                HStack {
                    Text("Город:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(work.town)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Зарплата:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(work.salary)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                Text(work.description)
                    .font(.caption)
                Spacer()
                Text(work.phone)
                    .font(.caption)
            }
        }
        
    }
}

struct AdvView_Previews: PreviewProvider {
    static var previews: some View {
        AdvView(work: example)
    }
}

#if DEBUG
let example2 = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111")
#endif
