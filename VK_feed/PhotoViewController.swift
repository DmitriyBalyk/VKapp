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
import RealmSwift

class PhotoViewController: UICollectionViewController  {
    
    //var photos = [Friends(name: "Жирафик-Рафик", photo: UIImage(contentsOfFile: "2"))]
    //Хранит коллекцию фото, полученную из базы
    var photos: Results<Item>?
    //Токен для уведомлений из базы
    var token: NotificationToken?
    var photosApi = VkApiController()
    //var photos = [Item]()
    var friendId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        photosApi.getPhoto(ownerID: friendId) { [weak self]  in
            self?.loadData()
            self?.collectionView.reloadData()
        }
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let image = realm.objects(Item.self)
            self.photos = image
        } catch {
            print(error)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos!.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        
        let url = URL(string: photos![indexPath.row].sizes.first!.url)
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
    //Получаем из базы фото и подписываемся на уведомления о ее изменении.
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        photos = realm.objects(Item.self)
        token = photos?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
            case .error(let error):
                fatalError("\(error)")
                
            }
        }
    }
    
}
