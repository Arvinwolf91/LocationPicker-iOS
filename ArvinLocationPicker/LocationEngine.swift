//
//  LocationEngine.swift
//  ArvinLocationPicker
//
//  Created by HEXA-arvin.sanmuga on 23/03/2017.
//  Copyright © 2017 hexainitiative. All rights reserved.
//

import UIKit
import CoreLocation
import LocationPicker
import MapKit
import Contacts

class LocationEngine: NSObject {
    
    class func searchLocation(_ completionHandler:@escaping (_ responseObject:Location) -> ()) {
        
        let locationPicker = LocationPickerViewController()
        
        // you can optionally set initial location
//        let location = CLLocation(latitude: 35, longitude: 35)
//        let initialPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), addressDictionary: ["City": "Palo Alto", CNPostalAddressStreetKey as String: "CA"])
//        let initialLocation = Location(name: "Home", location: location, placemark:initialPlacemark)
//        locationPicker.location = initialLocation
        // button placed on right bottom corner
        locationPicker.showCurrentLocationButton = true // default: true
        // default: navigation bar's `barTintColor` or `.whiteColor()`
        locationPicker.currentLocationButtonBackground = .blue
        // ignored if initial location is given, shows that location instead
        locationPicker.showCurrentLocationInitially = true // default: true
        locationPicker.mapType = .standard // default: .Hybrid
        
        // for searching, see `MKLocalSearchRequest`'s `region` property
        locationPicker.useCurrentLocationAsHint = true // default: false
        locationPicker.searchBarStyle = .prominent
        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"
        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"
        
        locationPicker.resultRegionDistance = 500 // default: 600
        
        // Selected location
        locationPicker.completion = { location in
          completionHandler(location!)
        }
        
        let window = UIApplication.shared.keyWindow
        let navController = window?.rootViewController as! UINavigationController
        navController.pushViewController(locationPicker, animated: true)
    }
    
}
