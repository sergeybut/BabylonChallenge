//
//  Post.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper_Realm
import ObjectMapper

class Post: Object, Mappable {
    
    @objc dynamic var postId = 0
    @objc dynamic var userId = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "postId"
    }
    
    var post:  Post {
        return Post(post: self)
    }
    
    convenience init(post: Post) {
        self.init()
        userId = post.userId
        postId = post.postId
        title = post.title
        body = post.body
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        postId <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}
