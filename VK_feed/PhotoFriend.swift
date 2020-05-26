//
//  PhotoFriend.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 16.05.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import RealmSwift

//Перечисления данных фото

struct ResponsePhoto: Decodable {
    let response: Response
}

struct Response: Decodable {
    let items: [Item]
}

class Item: Object, Decodable {
    @objc dynamic var id, albumID, ownerID: Int
    let sizes: [Size]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes
    }
}

class Size: Object, Decodable {
    @objc dynamic var type: String
    @objc dynamic var url: String
}
    
    /*required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        
        let values2 = try decoder.container(keyedBy: SizesKeys.self)
       //let mainValues = try values.nestedContainer(keyedBy: WeatherKeys.self, forKey: .sizes)
        self.image = try values2.decode(String.self, forKey: .image)
        self.size = try values2.decode(String.self, forKey: .size)
    }*/
