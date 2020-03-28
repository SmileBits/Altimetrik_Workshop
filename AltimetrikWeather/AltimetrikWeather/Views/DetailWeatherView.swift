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
        setDailyGraph()
        addSubview(detailSwitch)
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
        self.dailyChartView = LineChartView()
        dailyChartView?.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: TESTING DATA
        let yVals1 = (0..<14).map { (i) -> ChartDataEntry in
            let mult = 78 / 2
            let val = Double(arc4random_uniform(8) + 50)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<14).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(78) + 450)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals3 = (0..<14).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(78) + 500)
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.setCircleColor(.white)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: yVals2, label: "DataSet 2")
        set2.axisDependency = .right
        set2.setColor(.red)
        set2.setCircleColor(.white)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false

        let set3 = LineChartDataSet(entries: yVals3, label: "DataSet 3")
        set3.axisDependency = .right
        set3.setColor(.yellow)
        set3.setCircleColor(.white)
        set3.lineWidth = 2
        set3.circleRadius = 3
        set3.fillAlpha = 65/255
        set3.fillColor = UIColor.yellow.withAlphaComponent(200/255)
        set3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set3.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2, set3])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        dailyChartView?.data = data
        
        chartViewContainer.addSubview(dailyChartView!)
        
        NSLayoutConstraint.activate([
            dailyChartView!.topAnchor.constraint(equalTo: chartViewContainer.topAnchor, constant: 0),
            dailyChartView!.leadingAnchor.constraint(equalTo: chartViewContainer.leadingAnchor, constant: 0),
            dailyChartView!.trailingAnchor.constraint(equalTo: chartViewContainer.trailingAnchor, constant: 0),
            dailyChartView!.bottomAnchor.constraint(equalTo: chartViewContainer.bottomAnchor, constant: 0)
        ])
        
    }
    
    fileprivate func setHourlyGraph(){
        self.hourlyChartView = LineChartView()
        hourlyChartView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc fileprivate func didTapDismiss(_ sender:UIButton){
        self.delegate?.dismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
