//
//  FullScreenViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 18.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let countCell = 1

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(UINib(nibName: "FullscreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FullscreenCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullscreenCollectionViewCell", for: indexPath) as! FullscreenCollectionViewCell
        return cell
    }

}

