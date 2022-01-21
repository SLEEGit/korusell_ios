//
//  Message.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/21.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
