//
//  ReloadGroupsTable.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 30.06.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation
import RealmSwift

class ReloadGroupsTable: Operation {
    
    var outputGroupData: Results<Group>?
    var controller: MyGroupViewController
    
    init(controller: MyGroupViewController) {
        self.controller = controller
    }
    
    override func main() {
        guard let realm = try? Realm() else { return }
        outputGroupData = realm.objects(Group.self)
        controller.groups = outputGroupData
        controller.tableView.reloadData()
  }
}
