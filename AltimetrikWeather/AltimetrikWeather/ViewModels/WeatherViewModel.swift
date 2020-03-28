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
    
    init(_ weather:Weather) {
        self.latitude = weather.latitude
        self.longitude = weather.longitude
        self.timezone = weather.timezone
    }
}
