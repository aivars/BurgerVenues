//
//  CollectionViewController.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func findBurgers(){
        let burgerApi = BurgerApiConnect()
        foundBurgerVenues = []
        for venue in searchResults {
            guard let photoSuffix = venue["photo"]["suffix"].string else {return}
            guard let currentVenueName = venue["venue"]["name"].string else {return}
            let testPhotoUrl = "https://fastly.4sqi.net/img/general/500x500\(photoSuffix)"
            let newBurgerUrl = {(result: String) in
                if result != "error" {
                    DispatchQueue.main.async {
                        let burgerUrl = result
                        var burgerVenue = BurgerVenue()
                        burgerVenue.venueName = currentVenueName
                        burgerVenue.imageUrl = burgerUrl
                        self.foundBurgerVenues.append(burgerVenue)
                        self.collectionView.reloadData()
                    }
                }
            }
            burgerApi.verifyUrls(imageUrls: [testPhotoUrl], completionHandler: newBurgerUrl)
        }
    }
    
    
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
        if foundBurgerVenues.count > 12 {
            collectionView.isScrollEnabled = true
        }
        return foundBurgerVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let venue = foundBurgerVenues[indexPath.row]
        cell.setCell(venue: venue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = foundBurgerVenues[indexPath.row]
        coordinator?.showDetails(venueName: venue.venueName, photoUrl: venue.imageUrl)
    }
    
    func updateCollectionViewSize() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (view.frame.size.width - 52) / 2
            let height = width * 6 + 70
            collectionViewHeigt.constant = height
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            let width = (view.frame.size.width - 52) / 4
            let height = width * 3 + 40
            collectionViewHeigt.constant = height
        }
    }
}
