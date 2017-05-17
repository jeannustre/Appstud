//
//  PlaceResponse.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import ObjectMapper

// The model for a Place Response, ready to be mapped by AlamofireObjectMapper.
class PlaceResponse: Mappable {
    
    var html_attributions: [String]?
    var results: [Place]?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        results <- map["results"]
        status <- map["status"]
    }
}
