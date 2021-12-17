//
//  User.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

class User {
    var uid: String
    var email: String
    var name: String?
    var avatar: String?
    var phone: String?
    
    init(uid: String, name: String?, email: String, avatar: String?, phone: String?) {
        self.uid = uid
        self.email = email
        self.name = name ?? ""
        self.avatar = avatar ?? ""
        self.phone = phone ?? ""
    }
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.avatar = dictionary["avatar"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
    }

}
