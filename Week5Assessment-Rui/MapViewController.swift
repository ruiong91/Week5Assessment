//
//  MapViewController.swift
//  Week5Assessment-Rui
//
//  Created by Rui Ong on 24/02/2017.
//  Copyright © 2017 Rui Ong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var indexPathRow : Int? = 0
    var locationManager: CLLocationManager?
    
    var currentLocation = MKPointAnnotation()
    var stationLocation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //current location
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
        //station location
        mapView.delegate = self
        let validStationLat = BikeStation.bikeStations[indexPathRow!].latitude
        let validStationLng = BikeStation.bikeStations[indexPathRow!].longtitude
        stationLocation.coordinate = CLLocationCoordinate2D(latitude: validStationLat, longitude: validStationLng)
        
        
        print("station \(stationLocation.coordinate)")
        
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error finding location")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first{
            if location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000 {
                print("Found you!")
                locationManager?.stopUpdatingLocation()
                
                currentLocation.coordinate = location.coordinate
                print(currentLocation.coordinate)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKPinAnnotationView()
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: (currentLocation.coordinate), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
}
