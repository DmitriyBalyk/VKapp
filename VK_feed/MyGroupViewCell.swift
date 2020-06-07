//
//  MyGroupViewCell.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class MyGroupViewCell: UITableViewCell {
    
    @IBOutlet weak var photoGrp: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    @IBAction func imgGrp() {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.autoreverse],
                       animations: {
                        self.photoGrp.transform = self.scale
        }, completion: { _ in
            self.photoGrp.transform = .identity
        })
    }
}
