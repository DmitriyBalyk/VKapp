//
//  MyGroupViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import WebKit
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
    //var groups = [Group]()
    
    private var userGroup = [FirebaseUser]()
    private let ref = Database.database().reference(withPath: "userGroup")
    
    var controlRefresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsApi.getGroups()
        pairTableAndRealm()
        addRefreshControl()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeGroupViewCell", for: indexPath) as! MyGroupViewCell
        
        cell.groupLabel.text = groups?[indexPath.row].name
        let url = URL(string: groups?[indexPath.row].image ?? "")
        cell.photoGrp.image = UIImage(data: try! Data(contentsOf: url!))!
        return cell
    }
    
    func addRefreshControl (){
        controlRefresh.attributedTitle = NSAttributedString(string: "update")
        controlRefresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(controlRefresh)
    }
    
    @objc func refreshTable (){
        print("Start")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.controlRefresh.endRefreshing()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupViewController = segue.source as! AllGroupViewController
            
            if let indexPath = allGroupViewController.tableView.indexPathForSelectedRow {
                // Получаем   группу по индексу
                let group = allGroupViewController.filteredGroups[indexPath.row]
                // Проверяем, что такой группы нет в списке
                let userGroup = FirebaseUser(userId: Session.instance.userId, groupName: group.name)
                let ref = String(group.name) + " (" + String(Session.instance.userId) + ")"
                let userGroupRef = self.ref.child(ref)
                userGroupRef.setValue(userGroup.toAnyObject())
                
            }
        }
    }
    
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

