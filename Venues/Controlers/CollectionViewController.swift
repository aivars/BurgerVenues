//
//  CollectionViewController.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        updateCollectionViewSize()
        flowLayout.invalidateLayout()
        collectionView?.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var width = (view.frame.width - 42) / 2
        if UIDevice.current.userInterfaceIdiom == .pad {
            width = (view.frame.width - 72) / 4
        }
        return CGSize(width: width, height: width)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.burgerImage.image = #imageLiteral(resourceName: "burger")
        return cell
    }
    
    func updateCollectionViewSize() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (view.frame.size.width - 52) / 2
            let height = width * 6 + 50
            collectionViewHeigt.constant = height
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            let width = (view.frame.size.width - 52) / 4
            let height = width * 3
            collectionViewHeigt.constant = height
        }
    }
}
