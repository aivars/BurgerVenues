//
//  CollectionViewCell.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var burgerImage: UIImageView!
    @IBOutlet weak var vanueNameLbl: UILabel!
    
    func setCell (venue: BurgerVenue) {
        vanueNameLbl.text = venue.venueName
        
        burgerImage.kf.indicatorType = .activity
        guard let url = URL(string:venue.imageUrl) else {
            return
        }
        burgerImage.kf.setImage(with: url)
    }
    
}
