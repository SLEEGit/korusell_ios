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
        VStack {
            //                Later change to individual image
            if work.image != "" {
                Image(work.image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text(icon)
                    .font(.system(size: 50))
            }

            Form {
                Section {
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.gray)
                    HStack {
                        Text(name)
                            .font(.title2)
                        Divider()
                        Text(work.salary + " \u{20A9}")
                        //                    Поменять на символ вона
                            .font(.title3)
                    }
                    
                    HStack {
                        Text("Город")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Divider()
                        Text(work.town)
                            .font(.caption)
                    }
                    HStack {
                        Text("Виза")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Divider()
                        ForEach(work.visa, id: \.self) { visa in
                            Text(visa)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(work.description)
                        .font(.caption)
                        .padding(10)
                }
                Section {
                    Button(action: {
                        call(numberString: work.phone)
                    }) {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "phone.fill")
                            Text(work.phone)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    func call(numberString: String) {
        let telephone = "tel://"
        let formattedString = telephone + numberString
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
}

struct AdvView_Previews: PreviewProvider {
    static var previews: some View {
        AdvView(work: example)
    }
}

#if DEBUG
let example2 = Work(_id: "HNyHZZjtq298izgub", createdAt: "2021-11-28T03:58:20.665Z", updatedAt: "2021-11-28T03:58:20.665Z", category: "motel", salary: "3000000", visa: ["F4", "H2"], town: "Чхонджу", description: "г.Чхонджу 청주시 (Оксан-мён 옥산면) ЖК дисплеи (протирка, тейпинг, комса) Чуган 09:00~18:00 (чаноб 3 часа с утра) Зарплата 20-го числа, авансы Дорожные не выплачиваются Развоз имеется Жильё не предоставляют 3 девушки виза F4 생휴, Ёнча, 13~ая, нед.бонус есть Страховка 50% Обязательное знание языка Услуга бесплатная (аутсорсинг) 010-2369-6613", phone: "010 1233 1111", image: "factory")
#endif
