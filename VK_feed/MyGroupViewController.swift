//
//  MyGroupViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import FirebaseDatabase

final class GroupViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}

class MyGroupViewController: UITableViewController {
    
    //Хранит коллекцию групп, полученную из базы
    var groups: Results<Group>?
    //Токен для уведомлений из базы
    var token: NotificationToken?
    var groupsApi = VkApiController()
    var photoService: PhotoService?
    //var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: tableView)
        //groupsApi.getGroups(controller: self)
        pairTableAndRealm()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeGroupViewCell", for: indexPath) as! MyGroupViewCell
        
        guard let group = groups?[indexPath.row] else { return cell }
        let url = group.image
        guard let image = photoService?.photo(atIndexpath: indexPath, byUrl: url) else { return cell }
        cell.configure(with: group, image: image)
        return cell
    }
    
    //@IBAction func addGroup(segue: UIStoryboardSegue) {
    //     if segue.identifier == "addGroup" {
    //      let allGroupViewController = segue.source as! AllGroupViewController
    
    //      if let indexPath = allGroupViewController.tableView.indexPathForSelectedRow {
    //       let group = allGroupViewController.filteredGroups[indexPath.row]
    //      if !groups.contains(group) {
    //         groups.append(group)
    //     tableView.reloadData()
    //  }
    //  }
    //}
    //Получаем из базы группу и подписываемся на уведомления о ее изменении.
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        groups = realm.objects(Group.self)
        token = groups?.observe { [weak self] (changes: RealmCollectionChange) in
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
}

