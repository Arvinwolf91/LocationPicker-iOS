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
        LocationEngine.searchLocation { (responseObject) in
            self.targetLocation = responseObject.location
            let locationName = responseObject.name!
            let locationAddress = responseObject.address
            self.addressLabel.text = ("\(locationName) \(locationAddress)")
        }
    }
    
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

