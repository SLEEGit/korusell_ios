//
//  Util.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import Foundation
import SwiftUI
import MapKit

class Util {
    
    func getCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    func filter(city: String, category: String, unsortedList: [Service]) -> [Service] {
        
        var afterCategory: [Service] = []
        
        switch category {
        case "all":
            afterCategory = unsortedList
        case "food":
            afterCategory = unsortedList.filter { $0.category == "food" }
        case "shop":
            afterCategory = unsortedList.filter { $0.category == "shop" }
        case "connect":
            afterCategory = unsortedList.filter { $0.category == "connect" }
        case "docs":
            afterCategory = unsortedList.filter { $0.category == "docs" }
        case "transport":
            afterCategory = unsortedList.filter { $0.category == "transport" }
        case "law":
            afterCategory = unsortedList.filter { $0.category == "law" }
        case "money":
            afterCategory = unsortedList.filter { $0.category == "money" }
        case "health":
            afterCategory = unsortedList.filter { $0.category == "health" }
        case "car":
            afterCategory = unsortedList.filter { $0.category == "car" }
        case "nanny":
            afterCategory = unsortedList.filter { $0.category == "nanny" }
        case "study":
            afterCategory = unsortedList.filter { $0.category == "study" }
        case "tourism":
            afterCategory = unsortedList.filter { $0.category == "tourism" }
        default:
            afterCategory = unsortedList
        }
        
        switch city {
        case "Все города":
            return afterCategory
        case "Ансан":
            return afterCategory.filter { $0.city == "Ансан"}
        case "Хвасонг":
            return afterCategory.filter { $0.city == "Хвасонг"}
        case "Сеул":
            return afterCategory.filter { $0.city == "Сеул"}
        case "Инчхон":
            return afterCategory.filter { $0.city == "Инчхон"}
        case "Асан":
            return afterCategory.filter { $0.city == "Асан"}
        case "Чхонан":
            return afterCategory.filter { $0.city == "Чхонан"}
        case "Другой город":
            return afterCategory.filter { $0.city != "Чхонан" && $0.city != "Хвасонг" && $0.city != "Ансан" && $0.city != "Асан" && $0.city != "Сеул" && $0.city != "Инчхон" && $0.city != "Хвасонг"}
        default:
            return afterCategory
        }
    }
    
    
    
//        func parseCategory(category: String) -> [String] {
//            var list: [String] = []
//            if category == "zavod" {
//                list.append("🏭")
//                list.append("Завод")
//            } else if category == "motel" {
//                list.append("🏩")
//                list.append("Мотель")
//            } else if category == "stroyka" {
//                list.append("👷🏻‍♀️")
//                list.append("Стройка")
//            } else if category == "shchiktan" {
//                list.append("🍽")
//                list.append("Общепит")
//            } else if category == "selkhoz" {
//                list.append("🧑🏽‍🌾")
//                list.append("Сельхоз работы")
//            } else if category == "pochta" {
//                list.append("📦")
//                list.append("Почта")
//            } else if category == "ofis" {
//                list.append("💼")
//                list.append("Офис")
//            } else if category == "rabota_drugoye" {
//                list.append("👨‍🚀")
//                list.append("Другая работа")
//            } else if category == "kia" {
//                list.append("🚙")
//                list.append("KIA")
//            } else {
//                list.append("")
//                list.append("")
//            }
//            return list
//        }
//
//    func formatDate(date: String) -> String {
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd MMMM yyyy г."
//        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
//        let date: Date? = dateFormatterGet.date(from: date)
//
//        return dateFormatterPrint.string(from: date! as Date)
//
//    }
    
    
    
}
