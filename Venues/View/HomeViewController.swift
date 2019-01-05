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
import SwiftyJSON

class HomeViewController: UIViewController, Storyboarder {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeigt: NSLayoutConstraint!
    @IBOutlet weak var gateringLbl: UILabel!
    @IBOutlet weak var venuesLbl: UILabel!
    @IBOutlet weak var releadBtn: UIButton!
    weak var coordinator: MainCoordinator?
    
    
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 5000
    
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
        self.drawOverlay(location: Constants.Locations.tartuBusStationloc, radius: 1000)
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
