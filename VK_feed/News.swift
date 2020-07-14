//
//  News.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 12.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

struct NewsResponse: Decodable {
    let response: ItemNews
}
struct ItemNews: Decodable {
    let items: [NewsFeed]
    let next_from: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case next_from
    }
}

class NewsFeed: Decodable { 
    let sourceID = 0
    let date: Int = 0
    let text: String? = ""
    let attachments: [Attachments]
    let comments = 0
    let likes = 0
    let reposts = 0
    let views = 0
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
}
class Attachments: Decodable {
    let photo: Photos
}

class Photos: Decodable {
    let id, ownerID: Int
    let sizes: [Size]
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
        case userID = "user_id"
    }
}

class Sizes: Decodable {
    let url: String
    let type: String
    
}





/*struct News {
 var avatar, photo: UIImage?
 var name, text: String
 var date: Date?
 }
 
 final class NewsFeed {
 static func publicationNews() -> [News] {
 let news1 = News(avatar: UIImage(named: "1"), photo: UIImage(named: "4"), name: "Вася", text: "текст текст текст текст текст текст текст текст текст текст текст текст ", date: nil)
 let news2 = News(avatar: UIImage(named: "1"), photo: UIImage(named: "4"), name: "Петя", text: "текст текст текст текст текст текст текст текст текст текст текст текс текст текст текст текст текст текст текст текст текст текст текст текст", date: nil)
 let news3 = News(avatar: UIImage(named: "1"), photo: UIImage(named: "1"), name: "Вова", text: "текст текст текст текст текст текст текст текст текст текст текст текст ", date: nil)
 let news4 = News(avatar: UIImage(named: "1"), photo: UIImage(named: "6"), name: "Катя", text: "текст текст текст текст текст текст текст текст текст текст текст текс текст текст текст текст текст текст текст текст текст текст текст текст", date: nil)
 return [news1, news2, news3, news4]
 }
 }*/
