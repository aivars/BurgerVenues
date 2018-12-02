//
//  MainCoordinator.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(venueName: String, photoUrl: String) {
        let detailsVc = DetailsVievControler.instantiate()
        detailsVc.locationName = venueName
        detailsVc.photoUrl = photoUrl
        navigationController.pushViewController(detailsVc, animated: true)
        print("show details")
        
    }
    
    func navigate() {
        print("strat navigation")
    }
    

}
