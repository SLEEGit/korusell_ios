//
//  Util.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/04.
//

import Foundation
import SwiftUI
import MapKit

class Logging: ObservableObject {
    @Published var isSignedIn: Bool = false
}

class Util {
    
    func getCoordinates(address: String, completion: @escaping (String, String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion("", "")
                return
            }
            completion(placemarks?.first?.location?.coordinate.latitude.description ?? "", placemarks?.first?.location?.coordinate.longitude.description ?? "")
        }
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
//        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func call(numberString: String) {
        let telephone = "tel://"
        let formattedString = telephone + numberString
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
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
        case "party":
            afterCategory = unsortedList.filter { $0.category == "party" }
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
    
    func filterAdv(city: String, category: String, unsortedList: [Adv]) -> [Adv] {
        
        var afterCategory: [Adv] = []
        
        switch category {
        case "all":
            afterCategory = unsortedList
        case "work":
            afterCategory = unsortedList.filter { $0.category == "work" }
        case "transport":
            afterCategory = unsortedList.filter { $0.category == "transport" }
        case "house":
            afterCategory = unsortedList.filter { $0.category == "house" }
        case "phone":
            afterCategory = unsortedList.filter { $0.category == "phone" }
        case "hobby":
            afterCategory = unsortedList.filter { $0.category == "hobby" }
        case "car":
            afterCategory = unsortedList.filter { $0.category == "car" }
        case "electronic":
            afterCategory = unsortedList.filter { $0.category == "electronic" }
        case "children":
            afterCategory = unsortedList.filter { $0.category == "children" }
        case "clothes":
            afterCategory = unsortedList.filter { $0.category == "clothes" }
        case "sport":
            afterCategory = unsortedList.filter { $0.category == "sport" }
        case "pet":
            afterCategory = unsortedList.filter { $0.category == "pet" }
        case "change":
            afterCategory = unsortedList.filter { $0.category == "change" }
        default:
            afterCategory = unsortedList.filter  { $0.category == "zavod" }
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
    func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy г. в HH:mm"
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        let date: Date? = dateFormatterGet.date(from: date)

        return dateFormatterPrint.string(from: date! as Date)

    }
    
    func dateByTimeZone() -> String {
        let currentDate = Date()
         
        // 1) Create a DateFormatter() object.
        let format = DateFormatter()
         
        // 2) Set the current timezone to .current, or America/Chicago.
        format.timeZone = .current
         
        // 3) Set the format of the altered date.
        format.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
         
        // 4) Set the current date, altered by timezone.
        print(currentDate.description)
        print(format.string(from: currentDate))
        return format.string(from: currentDate)
    }
    
    
}

