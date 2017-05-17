//
//  Place.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import ObjectMapper

class Place: Mappable {
    
    var name: String?
    var id: String?
    var place_id: String?
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        place_id <- map["place_id"]
        latitude <- map["geometry.location.lat"]
        longitude <- map["geometry.location.lng"]
    }
    
}
