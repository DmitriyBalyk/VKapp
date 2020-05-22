//
//  User.swift
//  VK_APP
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


//Перечисления данных друзей
struct ResponseFriend: Decodable {
    let response: ItemsFriend
    
    struct ItemsFriend: Decodable {
        let items: [User]
    }
    
    class User: Decodable {
          var id: Int = 0
         var firstName: String = ""
         var lastName: String = ""
        var image: String = ""
        
        enum ItemsKeys: String, CodingKey {
            case id = "id"
            case firstName = "first_name"
            case lastName = "last_name"
            case image = "photo_50"
        }
        convenience required init(from decoder: Decoder) throws {
            self.init()
            let values = try decoder.container(keyedBy: ItemsKeys.self)
            self.id = try values.decode(Int.self, forKey: .id)
            self.firstName = try values.decode(String.self, forKey: .firstName)
            self.lastName = try values.decode(String.self, forKey: .lastName)
            self.image = try values.decode(String.self, forKey: .image)
        }
    }
    //сохранение погодных данных в Realm
    /*func saveUserData(_ users: [User]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            
            // начинаем изменять хранилище
            realm.beginWrite()
            
            // кладем все объекты класса погоды в хранилище
            realm.add(users)
            
            // завершаем изменения хранилища
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }*/
    
}



/*struct Friends {
    var name: String
    var photo, avatar: UIImage?
}
var friends2 = [Friends(name: "Жирафик-Рафик", photo: UIImage(named: "2"), avatar: UIImage(contentsOfFile: "2")),
                Friends(name: "Вася", photo: UIImage(named: "3"), avatar: UIImage(contentsOfFile: "3")),
                Friends(name: "Петя", photo: UIImage(named: "4"), avatar: UIImage(contentsOfFile: "4")),
                Friends(name: "Умник", photo: UIImage(named: "5"), avatar: UIImage(contentsOfFile: "5")),
                Friends(name: "Маня", photo: UIImage(named: "6"), avatar: UIImage(contentsOfFile: "6")),
                Friends(name: "Вуяня", photo: UIImage(named: "7"), avatar: UIImage(contentsOfFile: "7"))]*/

