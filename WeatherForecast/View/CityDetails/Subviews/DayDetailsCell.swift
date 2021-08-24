//
//  DayDetailsCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class DayDetailsCell: UITableViewCell {
    static let identifier = "DayDetailsCell"
    static let nibName = "DayDetailsCell"
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!

    func configureCell(with data: TodayForecastModel) {
        if let date = data.dateText {
            dayLabel.text = Date.dayFromDate(str: date)
        } else {
            dayLabel.text = "--"
        }
        if let humidity = data.main?.humidity {
            humidityLabel.text = "\(humidity)%"
        } else {
            humidityLabel.text = "--"
        }
        if let weatherList = data.weather,
           let weather = weatherList.first,
           let iconUrl = try? ServiceDetails.fetch().iconUrl,
           let icon = weather.icon {
            let imageUrl = "\(iconUrl)\(icon).png"
            if let url = URL(string: imageUrl) {
                do {
                    let imageData = try Data.init(contentsOf: url)
                    DispatchQueue.main.async {
                        self.weatherIconImage.image = UIImage(data: imageData)
                        self.weatherIconImage.isHidden = false
                    }
                } catch  {}
            }
        } else {
            weatherIconImage.isHidden = true
        }
        if let maxTemp = data.main?.maxTemperature {
            maxTemperature.text = NSString(format:"%d%@", Int(maxTemp),"\u{00B0}") as String
        } else {
            maxTemperature.text = "--"
        }
        if let minTemp = data.main?.minTemperature {
            minTemperature.text = NSString(format:"%d%@", Int(minTemp),"\u{00B0}") as String
        } else {
            minTemperature.text = "--"
        }
    }
}
