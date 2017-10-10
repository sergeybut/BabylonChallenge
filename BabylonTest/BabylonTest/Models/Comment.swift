//
//  Comment.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class Comment: Object, Mappable {
    
    @objc dynamic var postId = 0
    @objc dynamic var userId = 0
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var body = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    var comment:  Comment {
        return Comment(comment: self)
    }
    
    convenience init(comment: Comment) {
        self.init()
        postId = comment.postId
        userId = comment.userId
        name = comment.name
        email = comment.email
        body = comment.body
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        userId <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
