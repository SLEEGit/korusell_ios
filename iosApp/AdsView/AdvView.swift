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
        let date = Util().formatDate(date: work.updatedAt)
        let icon = Util().parseCategory(category: work.category)[0]
        let name = Util().parseCategory(category: work.category)[1]
        ScrollView {
            VStack {
//                Later change to individual image
                Text(icon)
                    .font(.system(size: 100))
//                    .frame(width: 100, height: 100)
                HStack {
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(10)
                    Spacer()
                }
                HStack {
                    Text(name)
                        .font(.title2)
                        .padding(10)
                    Divider()
                    Text(work.salary + " W")
//                    Поменять на символ вона
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(10)
                    Spacer()
                }
                
                HStack {
                    Text("Город:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(work.town)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(10)
                HStack {
                    Text("Виза:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(work._id)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(10)
                
                Text(work.description)
                    .font(.caption)
                    .padding(20)
                    .padding(.bottom, 50)
                
                Button(action: doSomething) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(work.phone)
                    }
                    .font(.title3)
                    .frame(width: 280, height: 50, alignment: .center)
                    .background(.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                }
            
            }
            
        }
        
    }
    
    func doSomething() {}
}

struct AdvView_Previews: PreviewProvider {
    static var previews: some View {
        AdvView(work: example)
    }
}

#if DEBUG
let example2 = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111")
#endif
