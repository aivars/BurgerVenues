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
    
    var locationName = "Unknown"
    var photoUrl = ""
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(locationName)
        print (photoUrl)
        
        updateUi()
    }
    
    fileprivate func updateUi() {

        let url = generatePhotoUrl(endPoint: photoUrl)
        navigationItem.title = locationName
        
        navigateBtn.roundCorners()
        navigateBtn.setShadow()
        
        foodImageView.layer.cornerRadius = 10
        
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: url)
    }
    
    func generatePhotoUrl(endPoint: String) -> URL {
        let api = "https://igx.4sqi.net/img/general/300x300"
        let endpoint = endPoint
        let url = URL(string: api + endpoint)
        
        return url!
        
    }
    
    
    @IBAction func navigate(_ sender: Any) {
        
        coordinator?.navigate()
    }
    
    

}
