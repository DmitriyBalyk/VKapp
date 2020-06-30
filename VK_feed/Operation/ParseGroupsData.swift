//
//  ParseGroupsData.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 30.06.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation
import RealmSwift

class ParseGroupsData: Operation {

    var vkApi = VkApiController()
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else { return }
        let groups = try! JSONDecoder().decode(ResponsGroup.self, from: data).response.items
        vkApi.saveData(data: groups)
    }
}
