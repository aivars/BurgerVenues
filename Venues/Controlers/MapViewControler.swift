//
//  MapViewControler.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import MapKit
import CoreLocation
import SwiftyJSON
import os.log

extension HomeViewController: MKMapViewDelegate {

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
        guard let location = view.annotation as? LocationSpot else {return}
        guard let locationName = location.title else {return}
        guard let photoSufix = location.photoSuffix else {return}
        let photoUrl = "https://fastly.4sqi.net/img/general/500x500\(photoSufix)"
        coordinator?.showDetails(venueName: locationName, photoUrl: photoUrl)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    // verify is location services available
    func verifyLocationStatus() {
        let status = CLLocationManager.authorizationStatus()
     
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationTracking()
            return
        case .denied, .restricted:
            //localisation status denied, alert user
            os_log("localisation status denied buy user", log: Log.general, type: .info)
        default:
            //location services are not available, request access
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startLocationTracking() {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        
        centerViewOnUserLocation()
    }

    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: false)

            searchForVenue()
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocationCoordinate2D {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func searchForVenue() {
        releadBtn.isHidden = true
        self.gateringLbl.isHidden = false
        
        let currentLocation = getCenterLocation(for: mapView)
        let url = "https://api.foursquare.com/v2/search/recommendations?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20182411&categoryId=4bf58dd8d48988d16c941735&limit=250&client_id=\(Constants.clientId)&client_secret=\(Constants.clientSecret)"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
        
            guard let data = data else {
                return
            }
            //VenueSpot requestID is parsed from JSON but nested data are not
//            let locationPoint = try? JSONDecoder().decode(VenueSpot.self, from: data)
            do {
                let json = try JSON(data: data)
                self.searchResults = json["response"]["group"]["results"].arrayValue
                
                DispatchQueue.main.async {
                    self.addVenuesOnMap()
                    self.findBurgers()
                    
                }
            } catch {
                os_log("SwiftyJson error", log: Log.general, type: .error)
            }
            
            
        })
        
        task.resume()
    }
    //MARK:- overlays & anotations
    func addVenuesOnMap(){
        self.gateringLbl.isHidden = true
        releadBtn.isHidden = false
        releadBtn.shake()
        // loop trough fethed data and add anotations on it
        for venue in searchResults {
            guard let currentVenueName = venue["venue"]["name"].string else {return}
            let lat = venue["venue"]["location"]["lat"].doubleValue
            let lng = venue["venue"]["location"]["lng"].doubleValue
            let currentVenueLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            guard let photoSuffix = venue["photo"]["suffix"].string else {return}
            
            // keep burger free zona around predefined "from" center, distance in meters
            if distance(from: Constants.tartuBusStationloc, to: currentVenueLocation) > 1000 {
                mapView.addAnnotation(LocationSpot(title: currentVenueName, coordinate: currentVenueLocation, photoSuffix: photoSuffix))
            }
        }
        
    }
        
    func drawOverlay(location: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: location, radius: radius)
        mapView.addOverlay(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.blue.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 1
        return renderer
    }
    
    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}
