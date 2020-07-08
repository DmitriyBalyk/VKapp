//
//  AllFriendsCell.swift
//  VK_APP
//
//  Created by Дмитрий Балык on 31.03.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class AllFriendsCell: UITableViewCell {
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet private weak var photoFriendImage: UIImageView!
    
    @IBOutlet weak var buttonHorizontallyConstr: NSLayoutConstraint!
    @IBOutlet weak var buttonVerticalCostraint: NSLayoutConstraint!
    
    // делаем анимацию по нажатию на фото друга в списке друзей
    let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    @IBAction private func imgButton() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.autoreverse],
                       animations: {
                        self.photoFriendImage.transform = self.scale
        }, completion: { _ in
            self.photoFriendImage.transform = .identity
        })
    }
    
    func configure(with friend: User, image: UIImage) {
        photoFriendImage.image = image
        friendsLabel.text = friend.firstName
        friendsLabel.text = friend.lastName
        
    }
}
