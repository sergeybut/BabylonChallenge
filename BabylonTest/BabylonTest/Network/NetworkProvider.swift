//
//  NetworkProvider.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
typealias CompoundDetail = (user: User, comments: [Comment])

struct NetworkProvider: Persistable {
    
    let service: BabylonHealthServiceAPI
    
    init(service: BabylonHealthServiceAPI = BabylonHealthServiceAPI()) {
        self.service = service
    }
    
    func loadPosts(completion:@escaping ([Post]?) -> Void) {
        service.load(ServiceRouter.loadPosts) {  result in
            switch result {
            case .success(let posts):
                self.insertPosts(posts: posts, update: true)
                completion(posts)
            case .error:
                let posts = self.getAll()
                completion(posts)
            }
        }
    }
    
    func loadDetailsFrom(post: Post, completion:@escaping (CompoundDetail?) -> Void) {
        service.loadDetails(userConvertible: ServiceRouter.searchUser(userId: post.userId), commentsConvertible: ServiceRouter.comments(postId: post.postId)) { result in
            
            switch result {
            case .success(let response):
                let user = response.user
                let userObject = User(user: user)
                self.insert(item: userObject, update: true)
                self.insertComments(comments: response.comments, update: true)
                completion(response)
            case .error:
                guard let user = self.getUserById(userId: post.userId) else {
                    completion(nil)
                    return
                }
                guard let comments = self.getCommentsByPostId(postId: post.postId) else {
                    completion(nil)
                    return
                }
                completion((user, comments))
            }
        }
    }
}
