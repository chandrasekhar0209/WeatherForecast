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
        if let weatherList = todayForecast.weather,
           let weather = weatherList.first {
            weatherType.text = weather.description
        } else {
            weatherType.text = WeatherSymbols.noValue.rawValue
        }
        if let temperature = todayForecast.main?.temperature {
            cityTemperature.text = String.temparatureWithDegreeSymbol(value: "\(temperature)")
        } else {
            cityTemperature.text = WeatherSymbols.noValue.rawValue
        }
        if let maxTemperature = todayForecast.main?.maxTemperature,
           let minTemperature = todayForecast.main?.minTemperature,
           let maxTempValue = String.temparatureWithDegreeSymbol(value: "\(maxTemperature)"),
           let minTempValue = String.temparatureWithDegreeSymbol(value: "\(minTemperature)") {
            cityMaxMinTemperature.text = NSString(format:TodayWeatherViewConstants.maxMinTempFormat.rawValue as NSString,
                                                  maxTempValue,
                                                  minTempValue) as String
        } else {
            cityMaxMinTemperature.text = WeatherSymbols.noValue.rawValue
        }
    }
}

enum TodayWeatherViewConstants: String {
    case maxMinTempFormat = "H:%@  L:%@"
}
