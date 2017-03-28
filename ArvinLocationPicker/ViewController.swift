//
//  ViewController.swift
//  ArvinLocationPicker
//
//  Created by HEXA-arvin.sanmuga on 22/03/2017.
//  Copyright © 2017 hexainitiative. All rights reserved.
//

import UIKit
import CoreLocation
import LocationPicker
import MapKit
import Contacts

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    // Current Location
    var currentLocationManager = CLLocationManager()
    var targetLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        
//        // Current Location
//        currentLocationManager.requestAlwaysAuthorization()
//        currentLocationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            currentLocationManager.delegate = self
//            currentLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            currentLocationManager.startUpdatingLocation()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Current Location
        currentLocationManager.requestAlwaysAuthorization()
        currentLocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            currentLocationManager.delegate = self
            currentLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            currentLocationManager.startUpdatingLocation()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mapTapped(_ sender: Any) {
//        searchLocation()
        
        LocationEngine.searchLocation { (responseObject) in
            self.targetLocation = responseObject.location
            let locationName = responseObject.name!
            let locationAddress = responseObject.address
            self.addressLabel.text = ("\(locationName) \(locationAddress)")
        }
    }
    
//    // Map
//    func searchLocation() {
//        
//        let locationPicker = LocationPickerViewController()
//
//        // you can optionally set initial location
//        let location = CLLocation(latitude: 35, longitude: 35)
//        let initialLocation = Location(name: "Home", location: location, placemark:placemark())
//        
//        locationPicker.location = initialLocation
//        
//        // button placed on right bottom corner
//        locationPicker.showCurrentLocationButton = true // default: true
//        
//        // default: navigation bar's `barTintColor` or `.whiteColor()`
//        locationPicker.currentLocationButtonBackground = .blue
//        
//        // ignored if initial location is given, shows that location instead
//        locationPicker.showCurrentLocationInitially = true // default: true
//        
//        locationPicker.mapType = .standard // default: .Hybrid
//        
//        // for searching, see `MKLocalSearchRequest`'s `region` property
//        locationPicker.useCurrentLocationAsHint = true // default: false
//        
//        locationPicker.searchBarStyle = .prominent
//        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"
//        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"
//        
//        // optional region distance to be used for creation region when user selects place from search results
//        locationPicker.resultRegionDistance = 500 // default: 600
//        
//        locationPicker.completion = { location in
//            // do some awesome stuff with location
//
//            self.targetLocation = location?.location
//
//            // Open In Maps App
//            let coordinate = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
//            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
//            mapItem.name = location?.address
//            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
//        }
//        
//        navigationController?.pushViewController(locationPicker, animated: true)
//    }
//    
//    // Map
//    func placemark() -> CLPlacemark {
//        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), addressDictionary: ["City": "Palo Alto", CNPostalAddressStreetKey as String: "CA"])
//    }
    
    // Current Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = (manager.location?.coordinate)! as CLLocationCoordinate2D
        let currentCoordinate = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        let targetCoordinate = targetLocation

        if targetCoordinate != nil {
            let distanceMetres = currentCoordinate.distance(from: targetCoordinate!)
            let distanceKilometres = distanceMetres / 1000.0
            distanceLabel.text = ("\(distanceKilometres.rounded().description) KM")
        }
    }
    

}

