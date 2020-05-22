//
//  Session.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 03.05.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class Session {
    
    private init(){}
    
    //синглтон для хранения данных
    static let instance = Session()
    //свойства
    var token = ""
    var userId = 21269005
    var baseUrl = "https://api.vk.com"
    
}
