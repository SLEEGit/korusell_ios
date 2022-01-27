//
//  Advertisement.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/03.
//

import Foundation
import SwiftUI

struct Adv: Codable, Identifiable {
    let id = UUID()
    let uid: String
    let name: String
    let price : String
    let category: String
    let city : String
    let description: String
    let phone: String
    let createdAt: String
    let images: String
    let updatedAt: String
    let isActive: String
    let subcategory: String
    let visa: [String]
    let gender: String
    let shift: String
    let age: [String]
    
    init(dictionary: [String: Any]) {
//        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.createdAt = dictionary["createdAt"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.images = dictionary["images"] as? String ?? ""
        self.updatedAt = dictionary["updatedAt"] as? String ?? ""
        self.isActive = dictionary["isActive"] as? String ?? ""
        self.subcategory = dictionary["subcategory"] as? String ?? ""
        self.visa = dictionary["visa"] as? [String] ?? []
        self.gender = dictionary["gender"] as? String ?? ""
        self.shift = dictionary["shift"] as? String ?? ""
        self.age = dictionary["age"] as? [String] ?? []
    }
    
    init(id: String, uid: String, name: String, category: String, city: String, price: String, phone: String, description: String, createdAt: String, images: String, updatedAt: String, isActive: String, subcategory: String, visa: [String], gender: String, shift: String, age: [String]) {
//        self.id = id
        self.uid = uid
        self.name = name
        self.category = category
        self.city = city
        self.phone = phone
        self.description = description
        self.price = price
        self.createdAt = createdAt
        self.images = images
        self.updatedAt = updatedAt
        self.isActive = isActive
        self.subcategory = subcategory
        self.visa = visa
        self.gender = gender
        self.shift = shift
        self.age = age
    }
}

