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

final class GroupViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}

class MyGroupViewController: UITableViewController {
    
    var groupsApi = VkApiController()
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        groupsApi.getGroups { [weak self] in
            self?.loadData()
            
        }
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let group = realm.objects(Group.self)
            self.groups = Array(group)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12 //groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeGroupViewCell", for: indexPath) as! MeGroupViewCell
        
        cell.groupLabel.text = groups[indexPath.row].name
        let url = URL(string: groups[indexPath.row].image)
        cell.photoGrp.image = UIImage(data: try! Data(contentsOf: url!))!
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
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

