//
//  News.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 12.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

struct News {
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
}
