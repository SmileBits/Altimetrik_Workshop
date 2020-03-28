//
//  DetailWeatherView.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import UIKit
import Charts

enum WeatherTime{
    case hourly
    case daily
}

protocol DismissDetailViewDelegate {
    func dismiss()
    //func didGraphForDetail()
}

class DetailWeatherView : RoundUIView{
    var viewModel:WeatherViewModel?
    var delegate:DismissDetailViewDelegate?
    
    var chartViewContainer:RoundUIView = {
        let view = RoundUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 25
        return view
    }()
    
    var hourlyChartView:LineChartView?
    var dailyChartView:LineChartView?
    
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
        cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.75)
        self.setupView()
    }
    
    private func setupView(){
        detailSwitch.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        setHourlyGraph()
        addSubview(detailSwitch)
        detailSwitch.selectedSegmentIndex = 0
        addSubview(chartViewContainer)
        NSLayoutConstraint.activate([
            detailSwitch.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            detailSwitch.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            detailSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            detailSwitch.heightAnchor.constraint(equalToConstant: 40),

            //We are assuming setDailyGraph was called correctly, refactor later.
            chartViewContainer.topAnchor.constraint(equalTo: detailSwitch.bottomAnchor, constant: 6),
            chartViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            chartViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            chartViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
            
        ])
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
        
        if let hourlyView = self.viewWithTag(21){
            hourlyView.removeFromSuperview()
        }
        
        self.dailyChartView = LineChartView()
        dailyChartView?.isUserInteractionEnabled = false
        dailyChartView?.translatesAutoresizingMaskIntoConstraints = false
        dailyChartView?.tag = 20
        
        dailyChartView?.setYAxisMaxWidth(.left, width: 2)
        dailyChartView?.setVisibleXRangeMaximum(2)
        
        let dataSet = ChartData(dataSet: viewModel!.weatherByTheDayDataSet)
        dailyChartView?.data = dataSet
        
        chartViewContainer.addSubview(dailyChartView!)
        
        NSLayoutConstraint.activate([
            dailyChartView!.topAnchor.constraint(equalTo: chartViewContainer.topAnchor, constant: 0),
            dailyChartView!.leadingAnchor.constraint(equalTo: chartViewContainer.leadingAnchor, constant: 0),
            dailyChartView!.trailingAnchor.constraint(equalTo: chartViewContainer.trailingAnchor, constant: 0),
            dailyChartView!.bottomAnchor.constraint(equalTo: chartViewContainer.bottomAnchor, constant: 0)
        ])
        
    }
    
    fileprivate func setHourlyGraph(){
        
        if let dailyView = self.viewWithTag(20){
            dailyView.removeFromSuperview()
        }
        
        self.hourlyChartView = LineChartView()
        hourlyChartView?.translatesAutoresizingMaskIntoConstraints = false
        hourlyChartView?.isUserInteractionEnabled = false
        hourlyChartView?.tag = 21
     
        let dataSet = ChartData(dataSet: viewModel!.weatherByTheDayDataSet)
        hourlyChartView?.setYAxisMaxWidth(.left, width: 2)
        hourlyChartView?.setVisibleXRangeMaximum(2)
        hourlyChartView?.data = dataSet
        
        chartViewContainer.addSubview(hourlyChartView!)
        
        NSLayoutConstraint.activate([
            hourlyChartView!.topAnchor.constraint(equalTo: chartViewContainer.topAnchor, constant: 0),
            hourlyChartView!.leadingAnchor.constraint(equalTo: chartViewContainer.leadingAnchor, constant: 0),
            hourlyChartView!.trailingAnchor.constraint(equalTo: chartViewContainer.trailingAnchor, constant: 0),
            hourlyChartView!.bottomAnchor.constraint(equalTo: chartViewContainer.bottomAnchor, constant: 0)
        ])
    }
    
    @objc fileprivate func didTapDismiss(_ sender:UIButton){
        self.delegate?.dismiss()
    }
    
    @objc fileprivate func didTapSwitch(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            self.setHourlyGraph()
        }else if sender.selectedSegmentIndex == 1{
            self.setDailyGraph()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
