//
//  HomeViewController.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, Storyboarder {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeigt: NSLayoutConstraint!
    @IBOutlet weak var gateringLbl: UILabel!
    @IBOutlet weak var venuesLbl: UILabel!
    @IBOutlet weak var releadBtn: UIButton!
    weak var coordinator: MainCoordinator?
    let clientId = "SKFVFAJQOCZ4SBO4UWWTAW21JB2YE2FVH0BCZRPYFILW2HV1"
    let clientSecret = "0C5B3OPU4DFMOBA2ZTO3LPKGBIM00ZY5ZYVOAJHRGPZQOJWG"
    let tartuBusStationloc = CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321)
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 5000
    var mapChangedFromUserInteraction = false
    var pinAnotation: LocationSpot?
    var searchResults = [JSON]()
    var foundBurgerVenues:[BurgerVenue] = []
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
        mapView.delegate = self
        locationManager.delegate = self
        verifyLocationStatus()
        updateUi()
        self.drawOverlay(location: tartuBusStationloc, radius: 1000)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for burger in foundBurgerVenues {
            print(burger)
        }
//        navigationController?.isNavigationBarHidden = true
    }
    
    private func updateUi() {
        updateCollectionViewSize()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 10
        releadBtn.roundCorners()
        releadBtn.imageEdgeInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)

        if UIDevice.current.userInterfaceIdiom == .pad {
            venuesLbl.font = venuesLbl.font.withSize(30)
        }
        
    }
    @IBAction func reload(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        searchForVenue()
    }
    
}
