//
//  PlacesProvider.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import GoogleMaps

fileprivate let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/"
fileprivate let format = "json"
fileprivate let apiKey = "AIzaSyCdGRFLuJ4Xpj7SPj3DukTo20tlGSvLTlg"
fileprivate let searchRadius = 2000 // meters
fileprivate let searchType = "bar"
fileprivate let mockLocation = CLLocation(latitude: 37.785, longitude: -122.406)

class PlacesProvider {
    
    var places: [Place]?
    
    func getNearbyPlaces(_ location: CLLocation?, completion: @escaping () -> ()) {
        let loc = (location != nil) ? CLLocation(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!) : mockLocation
        var urlString = "\(baseURL)\(format)?key=\(apiKey)&location=\(loc.coordinate.latitude),\(loc.coordinate.longitude)&radius=\(searchRadius)&type=\(searchType)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(urlString).responseObject { (response: DataResponse<PlaceResponse>) in
            let placeResponse = response.result.value
            if let results = placeResponse?.results {
                print("Got \(results.count) places")
                self.places = results
            }
            completion()
        }
    }
    
}


