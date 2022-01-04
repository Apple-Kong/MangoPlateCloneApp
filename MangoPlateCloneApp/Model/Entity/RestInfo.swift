//
//  RestInfo.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation
import UIKit
import CoreLocation


struct RestInfo {
    
    //추가하는 url
    var urlString: String?
    
    
    
    let detail: Restaurant
    
    var distance: String {
        let userLocation = CLLocation(latitude: 37.514322572335935, longitude: 127.06283102249932)
        let coordinate = CLLocation(latitude: Double(detail.y)!, longitude: Double(detail.x)!)
        
        print(coordinate)
        print(userLocation)
        
        let distanceInMeters = coordinate.distance(from: userLocation)// result is in meters
        print(distanceInMeters)
        let distanceInKiloMeters = distanceInMeters / 1000
        print(distanceInKiloMeters)
//        "x": ["127.06283102249932"],
//        "y": ["37.514322572335935"],
        
        
        return String(format: "%.2f", distanceInKiloMeters)
    }

}
