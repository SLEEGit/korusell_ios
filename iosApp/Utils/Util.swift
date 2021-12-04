//
//  Util.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import Foundation

class Util {
        func putEmoji(category: String) -> [String] {
            var list: [String] = []
            if category == "Zavod" {
                list.append("🏭")
                list.append("Завод")
            } else if category == "motel" {
                list.append("🏩")
                list.append("Мотель")
            } else if category == "stroyka" {
                list.append("👷🏻‍♀️")
                list.append("Стройка")
            } else if category == "shchiktan" {
                list.append("🍽")
                list.append("Общепит")
            } else if category == "selkhoz" {
                list.append("🧑🏽‍🌾")
                list.append("Сельхоз работы")
            } else if category == "pochta" {
                list.append("📦")
                list.append("Почта")
            } else if category == "ofis" {
                list.append("💼")
                list.append("Офис")
            } else if category == "rabota_drugoye" {
                list.append("👨‍🚀")
                list.append("Другая работа")
            } else {
                
            }
            return list
        }
    
    func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        print(date)

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy г."

        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        let date: Date? = dateFormatterGet.date(from: date)
        print(dateFormatterPrint.string(from: date! as Date))
        
        return dateFormatterPrint.string(from: date! as Date)
        
    }
    
}
