//
//  FirebaseUserGroup.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 03.06.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation
import Firebase

class FoundGroup: Decodable {
    let id: Int
    let name: String
    let photo50: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"
    }
}

class FoundGroupsData: Decodable {
    let count: Int
    let items: [FoundGroup]
}

class FoundGroupsResponse: Decodable {
    let response: FoundGroupsData
}

class FirebaseUser {
    // 1
    let userId: Int
    let groupName: String
    let ref: DatabaseReference?
    
    init(userId: Int, groupName: String) {
        // 2
        self.ref = nil
        self.userId = userId
        self.groupName = groupName
    }
    
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? Int,
            let groupName = value["groupName"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.userId = userId
        self.groupName = groupName
    }
    
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "userId": userId,
            "groupName": groupName
        ]
    }
}

