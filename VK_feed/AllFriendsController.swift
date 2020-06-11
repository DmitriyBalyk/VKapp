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
import RealmSwift
import FirebaseDatabase

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
    //Хранит коллекцию друзей, полученную из базы
    var friends: Results<User>?
    //Токен для уведомлений из базы
    var token: NotificationToken?
    var friendsApi = VkApiController()
    //var friends = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar.delegate = self
        //sortedFriends(friends: ResponseFriend.User)
        friendsApi.getFriendsMethod()
        pairTableAndRealm()
        
    }
    //Займусь позже(боковой бар алфавитного поиска по буквам)
    /*override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
     friendSection.map{$0.title}
     }*/
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friends!.count
    }
    
    //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    //    return friendSection[section].title
    // }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsCell", for: indexPath) as! AllFriendsCell
        let friend = friends![indexPath.row]
        let fullName = friend.firstName + " " + friend.lastName
        let url = URL(string: friends![indexPath.row].image)
        cell.photoFriendImage.image = UIImage(data: try! Data(contentsOf: url!))!
        cell.friendsLabel.text = fullName
        //cell.photo2.avatar.image = UIImage(named: friendSection[indexPath.section].items[indexPath.row].photo)
        return cell
    }
    //Получаем из базы друга и подписываемся на уведомления о ее изменении.
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        friends = realm.objects(User.self)
        token = friends?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
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
