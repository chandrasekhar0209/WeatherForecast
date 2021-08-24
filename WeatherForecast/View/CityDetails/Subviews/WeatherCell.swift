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
            timeLabel.text = "--"
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
                        self.weatherIcon.image = UIImage(data: imageData)
                    }
                } catch  {}
            }
        } else {
            humidityLabel.text = "--"
        }
        if let temperature = data.main?.temperature {
            temperatureLabel.text = NSString(format:"%d%@", Int(temperature),"\u{00B0}") as String
        } else {
            temperatureLabel.text = "--"
        }
    }
}
