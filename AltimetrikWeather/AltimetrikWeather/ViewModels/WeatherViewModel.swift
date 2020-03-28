//
//  WeatherViewModel.swift
//  AltimetrikWeather
//
//  Created by Alberto Echeverri on 3/28/20.
//  Copyright © 2020 Alberto Echeverri. All rights reserved.
//

import Foundation
import Charts

struct WeatherViewModel{
    
    private var latitude    :Double
    private var longitude   :Double
    private var timezone    :String
    
    private var weatherByTheHour : Hourly
    private var weatherByTheDay : Daily
    
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
    
    var weatherByTheHourDataSet: LineChartDataSet{
        get{
            var hourChartData:[ChartDataEntry] = [ChartDataEntry]()
            var index:Int = 0
            for data in weatherByTheHour.data!{
                index = index + 1
                if index < 4 {
                    let temp = data.temperature ?? 0
                    let time = data.time ?? 0
                    hourChartData.append(ChartDataEntry(x: Double(time), y: temp))
                }else{
                    break
                }
            }
            
            let set = LineChartDataSet(entries: hourChartData, label: "Tempeture by the Hour")
            set.axisDependency = .left
            set.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
            set.setCircleColor(.white)
            set.lineWidth = 2
            set.circleRadius = 3
            set.fillAlpha = 65/255
            set.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
            set.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set.drawCircleHoleEnabled = false
            
            return set
        }
    }
    
    var weatherByTheDayDataSet: LineChartDataSet{
        get{
            var hourChartData:[ChartDataEntry] = [ChartDataEntry]()
            var index:Int = 0
            for data in weatherByTheHour.data!{
                index = index + 1
                if index < 4{
                    let temp = data.temperature ?? 0
                    let time = data.time ?? 0
                    hourChartData.append(ChartDataEntry(x: Double(time), y: temp))
                }else{
                    break
                }
            }
            
            let set = LineChartDataSet(entries: hourChartData, label: "Tempeture by the Day")
            set.axisDependency = .left
            set.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
            set.setCircleColor(.white)
            set.lineWidth = 2
            set.circleRadius = 3
            set.fillAlpha = 65/255
            set.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
            set.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set.drawCircleHoleEnabled = false
            
            return set
        }
        
    }
    
    init(_ weather:Weather) {
        self.latitude = weather.latitude ?? 0
        self.longitude = weather.longitude ?? 0
        self.timezone = weather.timezone ?? ""
        //dangerous but I'm running out of time
        self.weatherByTheDay = weather.daily!
        self.weatherByTheHour = weather.hourly!
    }
}
