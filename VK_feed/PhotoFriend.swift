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


/*struct ResponsePhoto: Decodable {
    let response: Photo
}
struct Photo: Decodable {
    var id = 0
    var size = ""
    var image = ""
    
    
    enum CodingKeys: String, CodingKey {
        case items
        case sizes
        
    }
    
    enum ItemsKeys: String, CodingKey {
        case id = "owner_id"
        
    }
    
    enum SizesKeys: String, CodingKey {
        case size = "type"
        case image = "url"
    }*/
    
    /*required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        
        let values2 = try decoder.container(keyedBy: SizesKeys.self)
       //let mainValues = try values.nestedContainer(keyedBy: WeatherKeys.self, forKey: .sizes)
        self.image = try values2.decode(String.self, forKey: .image)
        self.size = try values2.decode(String.self, forKey: .size)
        
    }*/

/*struct ResponsePhoto: Decodable {
    let response: ItemsPhoto
}
    struct ItemsPhoto: Decodable {
        let items: [Photo]
    }
    
    struct Photo: Decodable {
        var id: Int = 0
        var sizes: [Sizes]
        
        enum PhotoKeys: String, CodingKey {
            case id = "owner_id"
        }
        
    }
    struct Sizes: Decodable {
        var size: String = ""
        var image: String = ""
        
        enum ItemsKeys: String, CodingKey {
            case image = "url"
            case size = "type"
            
        }
    }*/
