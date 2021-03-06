//
//  NewsController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 09.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
final class NewsViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}

class NewsController: UITableViewController {
    
    let news = NewsFeed.publicationNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.name.text = news[indexPath.row].name
        cell.avatar.image = news[indexPath.row].avatar
        cell.img.image = news[indexPath.row].photo
        cell.comment.text = news[indexPath.row].text
        
        let rightNow = Date()
        let calendar = Calendar.current
        let t = calendar.dateComponents([.minute], from: rightNow).minute!
        cell.date.text = String(t) + " минут назад"
        return cell
    }
}

