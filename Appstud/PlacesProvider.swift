//
//  PlacesProvider.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper
import GoogleMaps

fileprivate let baseNearbySearchURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/"
fileprivate let baseImageURL = "https://maps.googleapis.com/maps/api/place/photo"
fileprivate let format = "json"
fileprivate let apiKey = "AIzaSyCdGRFLuJ4Xpj7SPj3DukTo20tlGSvLTlg"
fileprivate let searchRadius = 2000 // meters
fileprivate let searchType = "bar"
fileprivate let mockLocation = CLLocation(latitude: 37.785, longitude: -122.406)
fileprivate let maxThumbnailWidth = 100

class PlacesProvider {
    
    var places: [Place]?
    
    // Fetches a list of Places, then calls the completion callback
    func getNearbyPlaces(_ location: CLLocation?, completion: @escaping () -> ()) {
        let loc = (location != nil) ?
            CLLocation(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!) : mockLocation
        var urlString = "\(baseNearbySearchURL)\(format)?key=\(apiKey)&location=\(loc.coordinate.latitude),\(loc.coordinate.longitude)&radius=\(searchRadius)&type=\(searchType)"
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
    
    // Adds a thumbnail image to a custom Marker
    func add(photo: String?, to: Marker) {
        if photo == nil {
            return
        }
        var urlString = "\(baseImageURL)?maxwidth=\(maxThumbnailWidth)&photoreference=\(photo!)&key=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(URL(string: urlString)!).responseImage { response in
            if let image = response.result.value {
                to.imageView.image = image
            }
        }
    }
    
}


