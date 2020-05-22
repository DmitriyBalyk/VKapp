//
//  NewsCell.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 09.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView! // фото юзера/группы
    @IBOutlet weak var name: UILabel! //Название группы/пользователя
    @IBOutlet weak var date: UILabel! //время опубликованного поста
    @IBOutlet weak var comment: UILabel! //Текстовый пост над картинкой
    @IBOutlet weak var img: UIImageView! //Картинка поста
    
    @IBOutlet weak var heartButton: UIButton! //лайк
    @IBOutlet weak var heartCounter: UILabel! //счетчик лайков
    
    @IBAction func commentButton(_ sender: UIButton) { //кнопка комментариев
        print("Кнопка комментария работает")
    }
    @IBAction func repostButton(_ sender: UIButton) { // кнопка репоста
        print("Кнопка репоста работает")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        heartCounter.text = "0"
        heartCounter.textColor = .black
        
    }
    
    @IBAction func like() {
        UIView.transition( //анимация сердца
            with:  heartButton,
            duration: 0.5,
            options: .transitionFlipFromTop,
            animations: {
                self.heartCounter.text = "0"
        })
        UIView.transition( //анимация цифры
            with:  heartCounter,
            duration: 0.5,
            options: .transitionFlipFromRight,
            animations: {
                self.heartCounter.text = "1"
        })
        heartButton.isSelected.toggle()
        heartButton.tintColor = heartButton.isSelected ? .red : .black
        heartCounter.textColor = heartButton.isSelected ? .red : .black
        heartCounter.text = heartButton.isSelected ? "1" : "0"
        
    }
    
}
