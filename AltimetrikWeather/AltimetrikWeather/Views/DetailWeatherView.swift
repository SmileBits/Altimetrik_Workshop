//
//  DetailWeatherView.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import UIKit

enum WeatherTime{
    case hourly
    case daily
}

class DetailWeatherView : RoundUIView{
    var viewModel:WeatherViewModel?
    
    lazy var detailSwitch:UISegmentedControl = {
        let view = UISegmentedControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSegment(withTitle: "Hourly", at: 0, animated: true)
        view.insertSegment(withTitle: "Daily", at: 1, animated: true)
        return view
    }()
    
    init(frame: CGRect, weatherViewModel:WeatherViewModel) {
        super.init(frame: frame)
        self.viewModel = weatherViewModel
        translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
    }
    
    private func setupView(){
        
    }
    
    fileprivate func updateView(with state:WeatherTime){
        switch state{
        case .daily:
            self.setDailyGraph()
        case .hourly:
            self.setHourlyGraph()
        }
    }
    
    fileprivate func setDailyGraph(){
        
    }
    
    fileprivate func setHourlyGraph(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
