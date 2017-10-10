//
//  DetailViewController.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!

    let networkProvider = NetworkProvider()

    var postItem: Post?
    
    var comments = [Comment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.dataSource = self
        loadData()
    }

    func loadData() {
        
        guard let post = postItem else {
            return
        }
        
        networkProvider.loadDetailsFrom(post: post) { result in
            
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.authorLabel.text = result.user.name
                self.postLabel.text = post.body
                self.commentsCountLabel.text = "\(result.comments.count)"
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! DetailsTableViewCell
        
        let commentItem = comments[indexPath.row]
        cell.populate(entry: commentItem)
        return cell
    }

}

