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

class WidthClass: ObservableObject {
    @Published var wirdth: Int = 400
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
    
//    func filter(city: String, category: String, unsortedList: [Service]) -> [Service] {
//
//        var afterCategory: [Service] = []
//
//        switch category {
//        case "all":
//            afterCategory = unsortedList
//        case "food":
//            afterCategory = unsortedList.filter { $0.category == "food" }
//        case "shop":
//            afterCategory = unsortedList.filter { $0.category == "shop" }
//        case "connect":
//            afterCategory = unsortedList.filter { $0.category == "connect" }
//        case "docs":
//            afterCategory = unsortedList.filter { $0.category == "docs" }
//        case "transport":
//            afterCategory = unsortedList.filter { $0.category == "transport" }
//        case "travel":
//            afterCategory = unsortedList.filter { $0.category == "travel" }
//        case "party":
//            afterCategory = unsortedList.filter { $0.category == "party" }
//        case "health":
//            afterCategory = unsortedList.filter { $0.category == "health" }
//        case "workshop":
//            afterCategory = unsortedList.filter { $0.category == "workshop" }
//        case "products":
//            afterCategory = unsortedList.filter { $0.category == "products" }
//        case "study":
//            afterCategory = unsortedList.filter { $0.category == "study" }
//        case "tourism":
//            afterCategory = unsortedList.filter { $0.category == "tourism" }
//        case "cars":
//            afterCategory = unsortedList.filter { $0.category == "cars" }
//        case "other":
//            afterCategory = unsortedList.filter { $0.category == "other" }
//        default:
//            afterCategory = unsortedList.filter { $0.category == "no" }
//        }
//
//        switch city {
//        case "?????? ????????????":
//            return afterCategory
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????"}
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????"}
//        case "???????????? ??????????":
//            return afterCategory.filter { $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "????????" && $0.city != "????????" && $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "??????????????"}
//        default:
//            return afterCategory
//        }
//    }
//
//    func filterAdv(city: String, category: String, unsortedList: [Adv]) -> [Adv] {
//
//        var afterCategory: [Adv] = []
//
//        switch category {
//        case "all":
//            afterCategory = unsortedList.filter { $0.category == "transport" || $0.category == "house" || $0.category == "phone" || $0.category == "hobby" || $0.category == "car" || $0.category == "electronic" || $0.category == "children" || $0.category == "clothes" || $0.category == "sport" || $0.category == "pet" || $0.category == "change" || $0.category == "other" || $0.category == "admin"}
//        case "transport":
//            afterCategory = unsortedList.filter { $0.category == "transport" || $0.category == "admin"}
//        case "house":
//            afterCategory = unsortedList.filter { $0.category == "house" || $0.category == "admin"}
//        case "phone":
//            afterCategory = unsortedList.filter { $0.category == "phone" || $0.category == "admin"}
//        case "hobby":
//            afterCategory = unsortedList.filter { $0.category == "hobby" || $0.category == "admin"}
//        case "car":
//            afterCategory = unsortedList.filter { $0.category == "car" || $0.category == "admin"}
//        case "electronic":
//            afterCategory = unsortedList.filter { $0.category == "electronic" || $0.category == "admin"}
//        case "children":
//            afterCategory = unsortedList.filter { $0.category == "children" || $0.category == "admin"}
//        case "clothes":
//            afterCategory = unsortedList.filter { $0.category == "clothes" || $0.category == "admin"}
//        case "sport":
//            afterCategory = unsortedList.filter { $0.category == "sport" || $0.category == "admin"}
//        case "pet":
//            afterCategory = unsortedList.filter { $0.category == "pet" || $0.category == "admin"}
//        case "change":
//            afterCategory = unsortedList.filter { $0.category == "change" || $0.category == "admin"}
//        case "other":
//            afterCategory = unsortedList.filter { $0.category == "other" || $0.category == "admin"}
//        default:
//            afterCategory = unsortedList.filter  { $0.category == "zavod" }
//        }
//
//        switch city {
//        case "?????? ????????????":
//            return afterCategory
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????" || $0.city == "admin"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????" || $0.city == "admin"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????" || $0.city == "admin"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????" || $0.city == "admin"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????" || $0.city == "admin"}
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????" || $0.city == "admin"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????" || $0.city == "admin"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????" || $0.city == "admin"}
//        case "???????????? ??????????":
//            return afterCategory.filter { $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "????????" && $0.city != "????????" && $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "??????????????" || $0.city == "admin"}
//        default:
//            return afterCategory
//        }
//    }
//
//    func filterWork(city: String, category: String = "work", subcategory: String, unsortedList: [Adv]) -> [Adv] {
//
//        var afterCategory: [Adv] = []
//        switch subcategory {
//        case "all":
//            afterCategory = unsortedList.filter { $0.subcategory == "factory" || $0.subcategory == "construction" || $0.subcategory == "motel" || $0.subcategory == "cafe" || $0.subcategory == "delivery" || $0.subcategory == "farm" || $0.subcategory == "office"}
//        case "factory":
//            afterCategory = unsortedList.filter { $0.subcategory == "factory"}
//        case "construction":
//            afterCategory = unsortedList.filter { $0.subcategory == "construction"}
//        case "motel":
//            afterCategory = unsortedList.filter { $0.subcategory == "motel"}
//        case "cafe":
//            afterCategory = unsortedList.filter { $0.subcategory == "cafe"}
//        case "delivery":
//            afterCategory = unsortedList.filter { $0.subcategory == "delivery"}
//        case "farm":
//            afterCategory = unsortedList.filter { $0.subcategory == "farm"}
//        case "office":
//            afterCategory = unsortedList.filter { $0.subcategory == "office"}
//        case "otherwork":
//            afterCategory = unsortedList.filter { $0.category == "otherwork"}
//        default:
//            afterCategory = unsortedList.filter  { $0.category == "none" }
//        }
//
//        switch city {
//        case "?????? ????????????":
//            return afterCategory
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????" || $0.city == "admin"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????" || $0.city == "admin"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????" || $0.city == "admin"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????" || $0.city == "admin"}
//        case "????????":
//            return afterCategory.filter { $0.city == "????????" || $0.city == "admin"}
//        case "??????????":
//            return afterCategory.filter { $0.city == "??????????" || $0.city == "admin"}
//        case "????????????":
//            return afterCategory.filter { $0.city == "????????????" || $0.city == "admin"}
//        case "??????????????":
//            return afterCategory.filter { $0.city == "??????????????" || $0.city == "admin"}
//        case "???????????? ??????????":
//            return afterCategory.filter { $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "????????" && $0.city != "????????" && $0.city != "????????????" && $0.city != "??????????????" && $0.city != "??????????" && $0.city != "??????????????" || $0.city == "admin"}
//        default:
//            return afterCategory
//        }
//    }
    
//        func parseCategory(category: String) -> [String] {
//            var list: [String] = []
//            if category == "zavod" {
//                list.append("????")
//                list.append("??????????")
//            } else if category == "motel" {
//                list.append("????")
//                list.append("????????????")
//            } else if category == "stroyka" {
//                list.append("?????????????????")
//                list.append("??????????????")
//            } else if category == "shchiktan" {
//                list.append("????")
//                list.append("??????????????")
//            } else if category == "selkhoz" {
//                list.append("???????????????")
//                list.append("?????????????? ????????????")
//            } else if category == "pochta" {
//                list.append("????")
//                list.append("??????????")
//            } else if category == "ofis" {
//                list.append("????")
//                list.append("????????")
//            } else if category == "rabota_drugoye" {
//                list.append("???????????")
//                list.append("???????????? ????????????")
//            } else if category == "kia" {
//                list.append("????")
//                list.append("KIA")
//            } else {
//                list.append("")
//                list.append("")
//            }
//            return list
//        }
//
    func formatDate(date: String) -> String {
        let iosdateFormatterGet = DateFormatter()
        let androidFormatterGet = DateFormatter()
        iosdateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        androidFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd MMMM yyyy ??. ?? HH:mm"
        dateFormatterPrint.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        let dated: Date? = iosdateFormatterGet.date(from: date) ?? androidFormatterGet.date(from: date)
        return dateFormatterPrint.string(from: dated! as Date)
    }
    
    func dateForAdv(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd MMMM yyyy ??. ?? HH:mm"
        dateFormatterPrint.dateFormat = "yy-MM-dd-HH-mm"
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        let dated: Date? = dateFormatterGet.date(from: date)
        if date != "" {
            return dateFormatterPrint.string(from: dated! as Date)
        } else {
            return ""
        }
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


    
