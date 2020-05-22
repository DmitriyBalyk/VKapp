//
//  PhotoViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 02.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class PhotoViewController: UICollectionViewController  {
    
    //var photos = [Friends(name: "Жирафик-Рафик", photo: UIImage(contentsOfFile: "2"))]
    var photos2 = VkApiController()
    var photos = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhoto { [weak self] photos in
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        
        let url = URL(string: photos[indexPath.row].sizes.first!.url)
        cell.photo2.image = UIImage(data: try! Data(contentsOf: url!))!
        //cell.photo2.image = photos[indexPath.row].photo
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goFoto"
        {
            let fotoController: GalleryViewController = segue.destination as! GalleryViewController
            let indexPath = collectionView.indexPathsForSelectedItems!.first!
            let name = "photo2" + String(indexPath.item + 1)
            fotoController.foto = UIImage(named: name)
        }
    }
    
}
