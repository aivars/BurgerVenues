//
//  DetailsVievControler.swift
//  Venues
//
//  Created by Aivars Meijers on 01/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class DetailsVievControler: UIViewController, Storyboarder {

    @IBOutlet weak var navigateBtn: UIButton!
    @IBOutlet weak var foodImageView: UIImageView!
    
    var locationName = "Unknown"
    var photoUrl = ""
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
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
        
        burgerApiPost()
    }
    
    func generatePhotoUrl(endPoint: String) -> URL {
        let api = "https://igx.4sqi.net/img/general/300x300"
        let endpoint = endPoint
        let url = URL(string: api + endpoint)
        
        return url!
        
    }
    

    
    func burgerApiPost() {
        
        let constantApiUrl = "https://pplkdijj76.execute-api.eu-west-1.amazonaws.com/prod/recognize" // "https://jsonplaceholder.typicode.com/posts" // json test host
        let testPhotoUrl = "https://igx.4sqi.net/img/general/500x500" + self.photoUrl
//        let testPhotoUrl = "https://igx.4sqi.net/img/general/500x500/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg"
        
        print(testPhotoUrl)
        let parameters: Parameters = [
            "urls": [testPhotoUrl]
            ]
        
        Alamofire.request(constantApiUrl, method: .post, parameters: parameters, encoding: JSONEncoding(options: [])).responseJSON {
            response in
            print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue) as Any)
            switch response.result {
            case .success:
                print(response)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func navigate(_ sender: Any) {
        
        coordinator?.navigate()
    }
    
    

}
