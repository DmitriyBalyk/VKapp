//
//  FirebaseUser.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 03.06.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser {
    // 1
    let userId: Int
    let groupId: Int
    let ref: DatabaseReference?
    
    init(userId: Int, groupId: Int) {
        // 2
        self.ref = nil
        self.userId = userId
        self.groupId = groupId
    }
    
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? Int,
            let groupId = value["groupId"] as? Int else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.userId = userId
        self.groupId = groupId
    }
    
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "userId": userId,
            "groupId": groupId
        ]
    }
}

