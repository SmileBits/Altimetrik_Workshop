//
//  WeatherInformationViewController.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class WeatherInformationViewController: UIViewController {
    
    private var weatherViewModel:WeatherViewModel?
    private var location:CLLocationCoordinate2D?
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var detailWeatherViewBottomConstraint:NSLayoutConstraint!
    
    //This is the detail view that shows detailed information about the location.
    var detailWeatherView:DetailWeatherView?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchButton.addTarget(self, action: #selector(didTapSearchButton(_:)), for: .touchUpInside)
        latitudeTextField.delegate = self
        longitudeTextField.delegate = self
        mapView.layer.cornerRadius = 25
    }
    
    @objc private func didTapSearchButton(_ sender:UIButton){
        if let latitudeText:String = latitudeTextField.text, let longitudeText:String = longitudeTextField.text{
            //We must be absolutely sure we got proper values.
            guard let latitude:Double = Double(latitudeText), let longitude:Double = Double(longitudeText) else {return}
            let inputLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            APIHandler.sharedInstance.getWeatherInformation(with: inputLocation) { (weather, error) in
                if let _ = error{
                                print(error?.localizedDescription ?? "Erro retrieving data")
                            }
                            //Response successful
                            if let uWeather = weather{
                                self.weatherViewModel = WeatherViewModel(uWeather)
                                DispatchQueue.main.async { [weak self] in
                                    self?.updateMapView()
                                }
                            }else{
                                print("Weather is nil") //I don't think we'll hit this block but better safe than sorry
                            }
            }
        }else{
            //Unproper values
        }
    }
    
    private func updateMapView(){
        //print("\(weatherViewModel?.lat ?? "") - \(weatherViewModel?.long ?? "") - \(weatherViewModel?.timeZoneDescription ?? "")")
        self.detailWeatherView = DetailWeatherView(frame: .zero, weatherViewModel: weatherViewModel!)
        view.addSubview(detailWeatherView!)
        detailWeatherViewBottomConstraint = detailWeatherView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 400)
        NSLayoutConstraint.activate([
            detailWeatherView!.heightAnchor.constraint(equalToConstant: 400),
            detailWeatherView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailWeatherView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailWeatherViewBottomConstraint
        ])
        
        UIView.animate(withDuration: 2.5) { [weak self] in
            self?.detailWeatherViewBottomConstraint.constant = 0
        }
    }

}

extension WeatherInformationViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let value = textField.text{
            if let _ = Double(value){
                //Input is correct.
            }else{
                textField.text = ""
                textField.placeholder = "Please input a numerical value"
            }
        }
    }
}

