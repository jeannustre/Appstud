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
        view = mapView
        
        /*let dummyMarker = GMSMarker()
        dummyMarker.position = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        dummyMarker.title = "Hello"
        dummyMarker.snippet = "World"
        dummyMarker.map = mapView*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
