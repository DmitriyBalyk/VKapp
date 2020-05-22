//
//  Drdfgerdg.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 11.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import Foundation

/*var friendSection = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsSearchBar.delegate = self
        sortedFriends(friends: friends)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendSection[section].items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as! FriendsTableViewCell
        
        cell.friendName.text = friendSection[indexPath.section].items[indexPath.row].name
        cell.friendSurname.text = friendSection[indexPath.section].items[indexPath.row].surname
        cell.friendImage.avatar.image = UIImage(named: friendSection[indexPath.section].items[indexPath.row].photo)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imagesSegue" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let imagesVC = segue.destination as! ImagesCollectionViewController
                imagesVC.friendsImages = friendSection[indexPath.section].items[indexPath.row].images
            }
        }
    }
    
    func sortedFriends(friends: [User]) {
        let userDictionary = Dictionary.init(grouping: friends)
        { $0.surname.prefix(1) }
        friendSection = userDictionary.map {Section(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title }
    }
}*/
