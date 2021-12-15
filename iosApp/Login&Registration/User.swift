//
//  User.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/15.
//

class User {
    var uid: String
    var email: String
    var displayName: String
    var avatar: String
    var phone: String
    
    init(uid: String, displayName: String?, email: String, avatar: String?, phone: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName ?? ""
        self.avatar = avatar ?? ""
        self.phone = phone ?? ""
    }

}
