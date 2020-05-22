//
//  HeartButton.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 08.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class Like: UIView {
    let heart = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
    let heartCount = UILabel(frame: CGRect(x: 30, y: 2, width: 35, height: 35))
    
    override func awakeFromNib (){
        super.awakeFromNib()
        
        heart.setImage(UIImage(systemName: "heart"), for: .normal)
        heart.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heart.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        self.addSubview(heart)
        
        heartCount.text = "0"
        heartCount.textColor = .black
        self.addSubview(heartCount)
    }
    
    @objc func buttonIsTapped(sender: UIButton) {
        UIView.transition( //анимация сердца
            with:  heart,
            duration: 0.5,
            options: .transitionFlipFromTop,
            animations: {
                self.heartCount.text = "0"
        })
        UIView.transition( //анимация цифры
            with:  heartCount,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: {
                self.heartCount.text = "1"
        })
        heart.isSelected.toggle()
        heart.tintColor = heart.isSelected ? .red : .black
        heartCount.textColor = heart.isSelected ? .red : .black
        heartCount.text = heart.isSelected ? "1" : "0"
    }
    
}
