//
//  MainViewController.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, Storyboarder {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeigt: NSLayoutConstraint!
    
    weak var coordinator: MainCoordinator?
    
    let client_id = "SKFVFAJQOCZ4SBO4UWWTAW21JB2YE2FVH0BCZRPYFILW2HV1"
    let client_secret = "0C5B3OPU4DFMOBA2ZTO3LPKGBIM00ZY5ZYVOAJHRGPZQOJWG"
    let tartuBusStationloc = CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321)
    var pinAnotation: LocationSpot?
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 5000
    
    // ToDo local storage for fetched data - Realm or CoreData
    var searchResults = [JSON]()
    var fakeData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    enum UIUserInterfaceIdiom : Int {
        case unspecified
        case phone // iPhone and iPod touch style UI
        case pad // iPad style UI
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        verifyLocationStatus()
        updateUi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        navigationController?.isNavigationBarHidden = true
    }
    
    private func updateUi() {
        
        updateCollectionViewSize()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 10
        
    }

}
