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
fileprivate let maxImageWidth = 1000
fileprivate let cellReuseIdentifier = "placeCell"

// This is our data fetcher, and also the data source for the views.
class PlacesProvider: NSObject {
    
    //MARK: - Class properties
    var places: [Place]?
    
    //MARK: - API methods
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
    
    func add(photo: String?, toCell: PlaceTableViewCell) {
        if photo == nil {
            return
        }
        var urlString = "\(baseImageURL)?maxwidth=\(maxImageWidth)&photoreference=\(photo!)&key=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(URL(string: urlString)!).responseImage { response in
            if let image = response.result.value {
                toCell.backgroundImage.image = image
            }
        }
    }
    
}

//MARK: - UITableViewDataSource Extension
extension PlacesProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlaceTableViewCell
        let place = places?[indexPath.item]
        cell.label.text = place?.name
        add(photo: place?.photo_reference, toCell: cell)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if places != nil {
            return (places?.count)!
        }
        return 0
    }
    
}


