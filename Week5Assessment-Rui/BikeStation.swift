//
//  Bike.swift
//  Week5Assessment-Rui
//
//  Created by Rui Ong on 24/02/2017.
//  Copyright © 2017 Rui Ong. All rights reserved.
//

import Foundation
import SwiftyJSON

class BikeStation {
    
    static var bikeStations : [BikeStation] = []
    
    var name : String
    var availableBikes : Int
    var latitude : Double
    var longtitude : Double
    
    init(json : JSON) {
        name = json["stationName"].stringValue
        availableBikes = json["availableBikes"].intValue
        latitude = json["latitude"].doubleValue
        longtitude = json["longtitude"].doubleValue
    }
}
