//
//  Service.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/20.
//

import Foundation

struct Service: Codable, Identifiable {
    
    let id = UUID()
    let uid: String
    let name: String
    let category: String
    let city : String
    let address : String
    let phone: String
    let description: String
    let latitude: String
    let longitude: String
    
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? String ?? ""
        self.longitude = dictionary["longitude"] as? String ?? ""
        }
    
    init(uid: String, name: String, category: String, city: String, address: String, phone: String, description: String, latitude: String, longitude: String) {
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.address = address
        self.phone = phone
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}
