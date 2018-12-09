//
//  Coordinator.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
