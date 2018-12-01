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
    
    var fakeData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    weak var coordinator: MainCoordinator?
    
    var pinAnotation: LocationSpot?
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 5000
    
    var searchResults = [JSON]()
    
    let TartuBusStationloc = CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321)
    
    
    
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
        
        updateCollectionViewSize()
        verifyLocationStatus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func updateUi() {
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 40
        
    }
    
   

    func searchForVenue() {
        let currentLocation = getCenterLocation(for: mapView)
        let url = "https://api.foursquare.com/v2/search/recommendations?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20182411&categoryId=4bf58dd8d48988d16c941735&limit=100&client_id=\(client_id)&client_secret=\(client_secret)"

        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared

        request.httpMethod = "GET"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in

            let json = JSON(data: data!)
            self.searchResults = json["response"]["group"]["results"].arrayValue

            DispatchQueue.main.async {
                self.addVenuesOnMap()
                print(json)
            }

        })

        task.resume()
    }

}
