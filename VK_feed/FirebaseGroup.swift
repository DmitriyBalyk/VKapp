//
//  FirebaseGroup.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 03.06.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation
import Firebase

class FirebaseGroup {
    // 1
    let name: String
    let id: Int
    let ref: DatabaseReference?
    
    init(name: String, id: Int) {
        // 2
        self.ref = nil
        self.name = name
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "name": name,
            "id": id,]
    }
}
