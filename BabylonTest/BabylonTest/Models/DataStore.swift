//
//  DataStore.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    
    associatedtype T
    associatedtype C
    associatedtype U
    
    func getAll() -> [T]?
    func getCommentsByPostId(postId: Int) -> [C]?
    func insert<T: Object>(item: T, update: Bool)
    func getUserById(userId: Int) -> U?
    func insertPosts(posts: [T], update: Bool)
    func insertComments(comments: [C], update: Bool)
}

extension Persistable {
    
    var realm: Realm? {
        return try? Realm()
    }
    
    func insert<T>(item: T, update: Bool) where T : Object {
        try? realm?.write {
            realm?.add(item.self, update:update)
        }
    }
    
    func getUserById(userId: Int) -> User? {
        return (realm?.object(ofType: User.self, forPrimaryKey: userId))
    }
    
    func getAll() -> [Post]? {
        return realm?.objects(Post.self).map {$0.post}
    }
    
    func getCommentsByPostId(postId: Int) -> [Comment]? {
        return realm?.objects(Comment.self).filter("postId == %@", postId).map {$0.comment}
    }
    
    func insertPosts(posts: [Post], update: Bool) {
        let posts = posts.map({ Post(post: $0) })
        try? realm?.write {
            realm?.add(posts, update:update)
        }
    }
    
    func insertComments(comments: [Comment], update: Bool) {
        try? realm?.write {
            realm?.add(comments, update:update)
        }
    }
}
