//
//  DayDetailsCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class DayDetailsCell: UITableViewCell {
    static let rowHeight: CGFloat = 35.0
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!

    func configureCell(with data: TodayForecastModel) {
        if let date = data.dateText {
            dayLabel.text = Date.dayFromDate(str: date)
        } else {
            dayLabel.text = WeatherSymbols.noValue.rawValue
        }
        if let humidity = data.main?.humidity {
            humidityLabel.text = "\(humidity)\(WeatherSymbols.percentage.rawValue)"
        } else {
            humidityLabel.text = WeatherSymbols.noValue.rawValue
        }
        if let weatherList = data.weather,
           let weather = weatherList.first,
           let icon = weather.icon {
            UIImageView.loadImage(in: weatherIconImage, with: icon)
        } else {
            weatherIconImage.isHidden = true
        }
        if let maxTemp = data.main?.maxTemperature {
            maxTemperature.text = String.temparatureWithDegreeSymbol(value: "\(maxTemp)")
        } else {
            maxTemperature.text = WeatherSymbols.noValue.rawValue
        }
        if let minTemp = data.main?.minTemperature {
            minTemperature.text = String.temparatureWithDegreeSymbol(value: "\(minTemp)")
        } else {
            minTemperature.text = WeatherSymbols.noValue.rawValue
        }
    }
}
