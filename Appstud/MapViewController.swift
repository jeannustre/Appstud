//
//  MapViewController.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    //MARK: - Class properties
    var camera: GMSCameraPosition?
    var mapView: GMSMapView?
    let placesProvider = PlacesProvider()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize our Camera and Map
        camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        // If the user location is available, display it on the map
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        // Add a botton padding to compensate the tab bar
        let barHeight = tabBarController?.tabBar.frame.height
        mapView?.padding = UIEdgeInsetsMake(0, 0, barHeight!, 0)
        // Add the map view to our main view
        view = mapView
        placesProvider.getNearbyPlaces(mapView?.myLocation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Register an observer for changed on mapView.myLocation
        mapView?.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Unregister the observer when view will disappear
        mapView?.removeObserver(self, forKeyPath: "myLocation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//MARK: - GMSMapViewDelegate extension
extension MapViewController: GMSMapViewDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "myLocation" {
            print("Value for location changed! ")
            print("\(mapView?.myLocation?.coordinate.latitude)::\(mapView?.myLocation?.coordinate.longitude)")
            // User location changed, query the places again
            placesProvider.getNearbyPlaces(mapView?.myLocation)
        }
    }
    
}
