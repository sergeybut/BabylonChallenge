//
//  User.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class User: Object, Mappable {
    
    @objc dynamic var email = ""
    @objc dynamic var userId = 0
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var username = ""
    @objc dynamic var website = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    var user:  User {
        return User(user: self)
    }
    
    convenience init(user: User) {
        self.init()
        email = user.email
        userId = user.userId
        name = user.name
        phone = user.phone
        username = user.username
        website = user.website
    }
    
    override class func primaryKey() -> String? {
        return "userId"
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        userId <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        username <- map["username"]
        website <- map["website"]
    }
}
