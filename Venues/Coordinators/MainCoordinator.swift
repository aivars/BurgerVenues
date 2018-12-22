//
//  MainCoordinator.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import os.log

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(venueName: String, photoUrl: String) {
        let detailsVc = DetailsVievControler.instantiate()
        detailsVc.venueName = venueName
        detailsVc.photoUrl = photoUrl
        navigationController.pushViewController(detailsVc, animated: true)
        
        os_log("show details", log: Log.general, type: .info)
        
    }
    
    func navigate() {
        os_log("start navigation", log: Log.general, type: .info)
    }

}
