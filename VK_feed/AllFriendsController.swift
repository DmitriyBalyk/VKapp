//
//  AllFriendsController.swift
//  VK_APP
//
//  Created by Дмитрий Балык on 31.03.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import WebKit
import Alamofire


final class FrendViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}

//struct Section {
//    var title: String
//    var items: [ResponseFriend.User]
//}

class AllFriendsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var friendSection = [Section]()
    var friends2 = VkApiController()
    var friends = [ResponseFriend.User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriendsMethod { [weak self] friends in
          self?.friends = friends
           self?.tableView.reloadData()
            print(friends)
            
        }
        //searchBar.delegate = self
        //sortedFriends(friends: ResponseFriend.User)
    }
    //Займусь позже(боковой бар алфавитного поиска по буквам)
    /*override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
     friendSection.map{$0.title}
     }*/
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friends.count
    }
    
    //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
    //    return friendSection[section].title
   // }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
      return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsCell", for: indexPath) as! AllFriendsCell
        let friend = friends[indexPath.row]
        let fullName = friend.firstName + " " + friend.lastName
        let url = URL(string: friends[indexPath.row].image)
        cell.photoFriendImage.image = UIImage(data: try! Data(contentsOf: url!))!
        cell.friendsLabel.text = fullName
        //cell.photo2.avatar.image = UIImage(named: friendSection[indexPath.section].items[indexPath.row].photo)
        return cell
    }
    
    /*func sortedFriends(friends: [ResponseFriend.User]) {
        let userDictionary = Dictionary.init(grouping: friends)
        { $0.name.prefix(1) }
        friendSection = userDictionary.map {Section(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title }
    }
    
}
extension AllFriendsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredGroups = friends2.filter({($0.name.lowercased().contains(searchText.lowercased()))})
        sortedFriends(friends: filteredGroups)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar, textDidChange searchText: String) {
        sortedFriends(friends: friends2)
        tableView.reloadData()
    }*/
    
}


//Альбом фоток по нажатию на фото "профиля"
/*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "imagesSegue" {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let imagesVC = segue.destination as! ImagesCollectionViewController
            imagesVC.photoFriendImage = friendSection[indexPath.section].items[indexPath.row].photo
        }
    }
}*/
