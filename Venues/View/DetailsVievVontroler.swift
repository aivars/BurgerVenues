//
//  DetailsVievControler.swift
//  Venues
//
//  Created by Aivars Meijers on 01/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVievControler: UIViewController, Storyboarder {

    @IBOutlet weak var navigateBtn: UIButton!
    @IBOutlet weak var foodImageView: UIImageView!
    
    var venueName = "Unknown"
    var photoUrl = ""
    var burgerVenue = BurgerVenue()
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        updateUi()
    }
    
    fileprivate func updateUi() {
        navigationItem.title = venueName
        
        navigateBtn.roundCorners()
        navigateBtn.setShadow()
        
        foodImageView.layer.cornerRadius = 10
        guard let url = URL(string: photoUrl) else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: url)
        
//        testBurgerUls()
        
    }
    
//
//    func testBurgerUls(){
//        let burgerApi = BurgerApiConnect()
//        let testPhotoUrl = "https://fastly.4sqi.net/img/general/500x500\(photoUrl)"
//        let newBurgerUrl = {(result: String) in
//            if result != "error" {
//                let burgerUrl = result
//                self.burgerVenue.venueName = self.venueName
//                self.burgerVenue.imageUrl = burgerUrl
//                foundBurgerVenues.append(burgerVenue)
//            }
//        }
//        burgerApi.verifyUrls(imageUrls: [testPhotoUrl], completionHandler: newBurgerUrl)
//    }
//
//
    @IBAction func navigate(_ sender: Any) {
        coordinator?.navigate()
    }

}
