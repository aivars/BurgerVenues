//
//  MapViewControler.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import MapKit
import CoreLocation

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? LocationSpot {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.pinTintColor = UIColor.red
                view.animatesDrop = true
                view.calloutOffset = CGPoint(x: -8, y: -3)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        let location = view.annotation as! LocationSpot
        guard let locationName = location.title else {return}
        guard let photoUrl = location.photoSuffix else {return}
    
        coordinator?.showDetails(venueName: locationName, photoUrl: photoUrl)

//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
//        location.mapItem(location: (pinAnotation?.coordinate)!).openInMaps(launchOptions: launchOptions)
    }
}



extension MainViewController: CLLocationManagerDelegate {

    // verify is location services available
    func verifyLocationStatus() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            StartLocationTracking()
            return
        case .denied, .restricted:
            //localisation status denied, you may like to inform user here
            print ("localisation status denied buy user")
        default:
            //location services are not available, request access
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func StartLocationTracking() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        
        centerViewOnUserLocation()
    }

    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate { 
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)

            searchForVenue()
        }
    }
    
    
 
    func getCenterLocation(for mapView: MKMapView) -> CLLocationCoordinate2D {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
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
    
    func addVenuesOnMap(){
        for venue in searchResults {
            guard let currentVenueName = venue["venue"]["name"].string else {return}
            let lat = venue["venue"]["location"]["lat"].doubleValue
            let lng = venue["venue"]["location"]["lng"].doubleValue
            let currentVenueLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//            let currentVenueId = venue["venue"]["id"].stringValue
            guard let photoSuffix = venue["photo"]["suffix"].string else {return}
            
            
            mapView.addAnnotation(LocationSpot(title: currentVenueName, coordinate: currentVenueLocation, photoSuffix: photoSuffix))
            
        }
    }
}
