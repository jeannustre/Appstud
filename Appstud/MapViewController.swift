//
//  MapViewController.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    //MARK: - Class properties
    var camera: GMSCameraPosition?
    var mapView: GMSMapView?
    
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
        // Add the map view to our mai  view
        view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
