//
//  APIHandler.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import Foundation
import CoreLocation

enum WeatherInformationError:Error{
    case unableToParseURL
    case unableToParseWeatherInformation(String)
    case unableToContactServer
}

struct APIHandler{
    private let decoder:JSONDecoder = JSONDecoder()
    static let sharedInstance = APIHandler()
    
    func getWeatherInformation(with location: CLLocationCoordinate2D, completion: @escaping (Weather?,WeatherInformationError?)->Void){
        let urlString:String = "\(Constants.darkSkyForecastURL)\(Constants.darkSkyAPIKey)/\(location.latitude),\(location.longitude)"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error{
                    completion(nil,.unableToContactServer)
                }else{
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200{
                            guard let retrievedData = data else {
                                completion(nil,.unableToParseWeatherInformation(""))
                                return
                            }
                            let weatherInformation = try? self.decoder.decode(Weather.self, from: retrievedData)
                            completion(weatherInformation,nil)
                        }
                    }
                }
            }.resume()
        }else{
            completion(nil,.unableToParseURL)
        }
    }
}
