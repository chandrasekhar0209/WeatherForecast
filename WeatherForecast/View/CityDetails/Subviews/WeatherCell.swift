//
//  WeatherCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"
    static let nibName = "WeatherCell"
    static let cellSize: CGSize = CGSize(width: 70.0, height: 110.0)
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    func configureCell(with data: TodayForecastModel) {
        if let date = data.dateText {
            timeLabel.text = Date.weatherTimeFormat(str: date)
        } else {
            timeLabel.text = WeatherSymbols.noValue.rawValue
        }
        if let humidity = data.main?.humidity {
            humidityLabel.text = "\(humidity)\(WeatherSymbols.percentage.rawValue)"
        } else {
            humidityLabel.text = WeatherSymbols.noValue.rawValue
        }
        if let weatherList = data.weather,
           let weather = weatherList.first,
           let icon = weather.icon {
            UIImageView.loadImage(in: weatherIcon, with: icon)
        } else {
            humidityLabel.text = WeatherSymbols.noValue.rawValue
        }
        if let temperature = data.main?.temperature {
            temperatureLabel.text = String.temparatureWithDegreeSymbol(value: "\(temperature)")
        } else {
            temperatureLabel.text = WeatherSymbols.noValue.rawValue
        }
    }
}
