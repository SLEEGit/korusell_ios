//
//  Util.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import Foundation
import SwiftUI

class Util {
        func parseCategory(category: String) -> [String] {
            var list: [String] = []
            if category == "zavod" {
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
            } else if category == "kia" {
                list.append("🚙")
                list.append("KIA")
            } else {
                list.append("")
                list.append("")
            }
            return list
        }
    
    func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy г."
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        let date: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatterPrint.string(from: date! as Date)
        
    }
    
}

