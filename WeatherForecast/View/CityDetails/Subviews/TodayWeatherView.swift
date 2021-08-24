//
//  TodayWeatherView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class TodayWeatherView: UIView {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    @IBOutlet weak var cityMaxMinTemperature: UILabel!
    static let nibName = "TodayWeatherView"
    
    func configureView(with todayForecast: TodayForecastModel) {
        cityName.text = todayForecast.cityName
        if let weatherList = todayForecast.weather, let weather = weatherList.first {
            weatherType.text = weather.description
        } else {
            weatherType.text = "--"
        }
        if let temperature = todayForecast.main?.temperature {
            cityTemperature.text = NSString(format:"%d%@", Int(temperature),"\u{00B0}") as String
        } else {
            cityTemperature.text = "--"
        }
        if let maxTemperature = todayForecast.main?.maxTemperature,
           let minTemperature = todayForecast.main?.minTemperature {
            cityMaxMinTemperature.text = NSString(format:"H:%d%@  L:%d%@", Int(maxTemperature), "\u{00B0}", Int(minTemperature), "\u{00B0}") as String
        } else {
            cityMaxMinTemperature.text = "--"
        }
    }
}
