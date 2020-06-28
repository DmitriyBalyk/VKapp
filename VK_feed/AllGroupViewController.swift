//
//  AllGroupViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

final class SearchGroupViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 1
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
        
    }
}

class AllGroupViewController: UITableViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    
    var filteredGroups = [Group]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // searchBar.delegate = self
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  //      if searching {
       //     return filteredGroups.count
     //   }
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupViewCell", for: indexPath) as! AllGroupViewCell
        //let group = groups[indexPath.row]
   //     let group: ResponsGroup.Group
     //   if searching {
      //      group = filteredGroups[indexPath.row]
      //  } else {
      //      group = groups[indexPath.row]
     //   }
        cell.allGroupName.text = filteredGroups[indexPath.row].name
         let url = URL(string: filteredGroups[indexPath.row].image)
               cell.photoGroup.image = UIImage(data: try! Data(contentsOf: url!))! 
        return cell
    }
}

/*extension AllGroupViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = filteredGroups.filter({ (group: allGroup) -> Bool in
            return group.groupName.lowercased().contains(searchText.lowercased())
        })
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = filteredGroups.filter({ (group: allGroup) -> Bool in
            return group.groupName.lowercased().contains(searchText.lowercased())
        })
        searching = true
        tableView.reloadData()
    }
}*/
