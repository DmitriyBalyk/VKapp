//
//  NewsCell.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 09.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet private weak var avatar: UIImageView! // фото юзера/группы
    @IBOutlet private weak var name: UILabel! //Название группы/пользователя
    @IBOutlet weak var dateLabel: UILabel! //время опубликованного поста
    @IBOutlet private weak var textPost: UILabel! //Текстовый пост над картинкой
    @IBOutlet private weak var img: UIImageView! //Картинка поста
    
    @IBOutlet private weak var heartButton: UIButton! //лайк
    @IBOutlet private weak var heartCounter: UILabel! //счетчик лайков
    
    @IBOutlet weak var commentCounter: UILabel! // счетчик комментариев
    @IBAction private func commentButton(_ sender: UIButton) { //кнопка комментариев
        print("Кнопка комментария работает")
    }
    @IBOutlet weak var repostCounter: UILabel! //счетчик репоста
    @IBAction private func repostButton(_ sender: UIButton) { // кнопка репоста
        print("Кнопка репоста работает")
    }
    @IBOutlet private weak var viewCounter: UILabel! //счетчик просмотра
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        heartCounter.text = "0"
        heartCounter.textColor = .black
        
    }
    
    func configure(with new: NewsFeed) {
        dateLabel.text = Date(timeIntervalSince1970: TimeInterval(new.date)).timeAgo(numericDates: false) 
        textPost.text = new.text
        viewCounter.text = String(new.views)
        repostCounter.text = String(new.reposts)
        commentCounter.text = String(new.comments)
        heartCounter.text = String(new.likes)
    }
    
    @IBAction private func like() {
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
