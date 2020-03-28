//
//  WeatherInformationViewController.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherInformationViewController: UIViewController {
    
    private var weatherViewModel:WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Testing location coordinatesw: 37.8267,-122.4233
        APIHandler.sharedInstance.getWeatherInformation(with: CLLocationCoordinate2D(latitude: 37.8267, longitude: -122.4233)) { (weather, error) in
            if let _ = error{
                print(error?.localizedDescription ?? "Erro retrieving data")
            }
            //Response successful
            if let uWeather = weather{
                self.weatherViewModel = WeatherViewModel(uWeather)
//                DispatchQueue.main.async { [weak self] in
//                    //Do UI Updates
//                }
            }else{
                print("Weather is nil") //I don't think we'll hit this block but better safe than sorry
            }
            
        }
    }


}

