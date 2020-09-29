//
//  LocationServices.swift
//  WattsUp
//
//  Created by Gopi Krishna on 21/04/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import Foundation
import CoreLocation


class LocationServices: NSObject, CLLocationManagerDelegate {

    static let shared = LocationServices()
    let locationManager : CLLocationManager
    var currentLocation : CLLocation
    var locationInfoCallBack: ((_ info:LocationInformation)->())?

    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        currentLocation = CLLocation()
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func start(locationInfoCallBack:@escaping ((_ info:LocationInformation)->())) {
        self.locationInfoCallBack = locationInfoCallBack
        locationManager.requestAlwaysAuthorization()
    }

    func stop() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        print(mostRecentLocation)
        let info = LocationInformation()
        info.latitude = mostRecentLocation.coordinate.latitude
        info.longitude = mostRecentLocation.coordinate.longitude
        self.currentLocation = mostRecentLocation

        //now fill address as well for complete information through lat long ..
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(mostRecentLocation) { (placemarks, error) in
            guard let placemarks = placemarks, let placemark = placemarks.first else { return }
            if let city = placemark.locality,
                let state = placemark.administrativeArea,
                let zip = placemark.postalCode,
                let locationName = placemark.name,
                let thoroughfare = placemark.thoroughfare,
                let country = placemark.country {
                info.city     = city
                info.state    = state
                info.zip = zip
                info.address =  locationName + ", " + (thoroughfare as String)
                info.country  = country
            }
           // self.locationInfoCallBack!(info)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationManager.stopUpdatingLocation()
    }
}

class LocationInformation {
    var city:String?
    var address:String?
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    var zip:String?
    var state :String?
    var country:String?
    init(city:String? = "",address:String? = "",latitude:CLLocationDegrees? = Double(0.0),longitude:CLLocationDegrees? = Double(0.0),zip:String? = "",state:String? = "",country:String? = "") {
        self.city    = city
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.zip        = zip
        self.state = state
        self.country = country
    }
}
