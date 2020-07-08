//
//  AllGroupViewCell.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit


class AllGroupViewCell: UITableViewCell {

    @IBOutlet private weak var allGroupName: UILabel!
    @IBOutlet private weak var photoGroup: SearchGroupViewBounds!
    
    func configure(with group: Group, image: UIImage) {
        photoGroup.image = image
        allGroupName.text = group.name
    }
}
