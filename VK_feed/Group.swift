//
//  Group.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 03.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

//Перечисления данных групп
struct ResponsGroup: Decodable {
    let response: ItemsGroup
}
struct ItemsGroup: Decodable {
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    
    enum ItemsKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "photo_200"
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.image = try values.decode(String.self, forKey: .image)
        
    }
}


//struct allGroup: Equatable{
    
//    var groupName: String
 //   var photoImage2: UIImage?
    
//}

