//
//  FullScreen2ViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 19.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit


class FullScreen2ViewController: UICollectionViewController {

 let countCell = 1

    
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.delegate = self
            collectionView.dataSource = self
            //collectionView.register(UINib(nibName: "FullscreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FullscreenCollectionViewCell")
            
        }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgs.count
        }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullscreenCollectionViewCell", for: indexPath) as! FullscreenCollectionViewCell
            return cell
        }

    }

