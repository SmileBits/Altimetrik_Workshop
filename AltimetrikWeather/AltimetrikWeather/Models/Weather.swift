//
//  Weather.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import Foundation

struct Weather : Codable{
    var latitude    :Double?
    var longitude   :Double?
    var timezone    :String?
    
//    var currently   :Currently?
//    //var minutely    :Minutely
      var hourly      :Hourly?
      var daily       :Daily?
}

struct Currently : Codable{
    var time       :Int?
    var summary    :String?
    var icon       :String?
    var nearestStormDistance: Int?
    var precipIntensity: Double?
    var precipIntensityError: Double?
    var precipProbability: Int?
    var precipType: String?
    var temperature: Double?
    var apparentTemperature: Double?
    var dewPoint: Double?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var windGust: Double?
    var windBearing: Int?
    var cloudCover: Double?
    var uvIndex: Int?
    var visibility: Double?
    var ozone: Double?
}


//struct Minutely : Codable{
//
//    struct WeatherByMinute:Codable{
//        var time: Int
//        var precipIntensity: Double
//        var precipIntensityError: Double
//        var precipProbability: Int
//        var precipType: String
//    }
//
//    var summary: String
//    var icon: String
//    var data: [WeatherByMinute]
//}


struct Hourly : Codable{
    
    struct WeatherByHour:Codable{
        var time: Int?
//        var summary: String?
//        var icon: String?
//        var precipIntensity: Double?
//        var precipProbability: Int?
//        var precipType: String?
        var temperature: Double?
        var apparentTemperature: Double?
//        var dewPoint: Double?
//        var humidity: Double?
//        var pressure: Double?
//        var windSpeed: Double?
//        var windGust: Double?
//        var windBearing: Int?
//        var cloudCover: Double?
//        var uvIndex: Int?
//        var visibility: Double?
//        var ozone: Double?
    }

    var summary: String?
    var icon: String?
    var data: [WeatherByHour]?

}

struct Daily : Codable{

    struct WeatherByDay:Codable{
        var time: Int?
        var summary: String?
        var icon: String?
//        var sunriseTime: Int
//        var sunsetTime: Int
//        var moonPhase: Double
//        var precipIntensity: Double
//        var precipIntensityMax: Double
//        var precipIntensityMaxTime: Int
//        var precipProbability: Double
//        var precipType: String
        var temperatureHigh: Double?
        var temperatureHighTime: Int?
        var temperatureLow: Double?
        var temperatureLowTime: Int?
        var apparentTemperatureHigh: Double?
        var apparentTemperatureHighTime: Int?
        var apparentTemperatureLow: Double?
        var apparentTemperatureLowTime: Int?
//        var dewPoint: Double
//        var humidity: Double
//        var pressure: Double
//        var windSpeed: Double
//        var windGust: Double
//        var windGustTime: Int
//        var windBearing: Int
//        var cloudCover: Double
//        var uvIndex: Int
//        var uvIndexTime: Int
//        var visibility: Double
//        var ozone: Double
        var temperatureMin: Double?
        var temperatureMinTime: Int?
        var temperatureMax: Double?
        var temperatureMaxTime: Int?
        var apparentTemperatureMin: Double?
        var apparentTemperatureMinTime: Int?
        var apparentTemperatureMax: Double?
        var apparentTemperatureMaxTime: Int?
    }

    var summary: String?
    var icon: String?
    var data: [WeatherByDay]?
}
