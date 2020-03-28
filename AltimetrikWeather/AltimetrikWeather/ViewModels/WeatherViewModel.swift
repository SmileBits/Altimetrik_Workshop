//
//  WeatherViewModel.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import Foundation

struct WeatherViewModel{
    
    private var latitude    :Double
    private var longitude   :Double
    private var timezone    :String
    
    var lat : String{
        get{
            return "Latitude: \(latitude)"
        }
    }
    
    var long : String{
        get {
            return "Longitude: \(longitude)"
        }
    }
    
    var timeZoneDescription : String{
        get{
            return "Region: \(timezone)"
        }
    }
    
    init(_ weather:Weather) {
        self.latitude = weather.latitude ?? 0
        self.longitude = weather.longitude ?? 0
        self.timezone = weather.timezone ?? ""
    }
}
