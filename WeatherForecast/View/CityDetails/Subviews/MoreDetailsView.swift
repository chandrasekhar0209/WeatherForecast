//
//  MoreDetailsView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class MoreDetailsView: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "MoreDetailsView"
    static let nibName = "MoreDetailsView"
    var todayForecast: TodayForecastModel!
    func configureCell(with data: TodayForecastModel?) {
        todayForecast = data
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.register(UINib(nibName: MoreDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: MoreDetailsCell.identifier)
        tableView.reloadData()
    }
}

extension MoreDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension MoreDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayForecast == nil ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreDetailsCell.identifier) as? MoreDetailsCell,
              let sunrise = todayForecast.system?.sunrise,
              let sunset = todayForecast.system?.sunset,
              let humidity = todayForecast.main?.humidity,
              let windSpeed = todayForecast.wind?.speed,
              let feelsLike = todayForecast.main?.feelsLike,
              let pressure = todayForecast.main?.pressure,
              let visibility = todayForecast.visibility else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.configureCell(text1: "SUNRISE",
                               text2: Date.sunRiseTimeFormat(timeStamp: sunrise),
                               text3: "SUNSET",
                               text4: Date.sunRiseTimeFormat(timeStamp: sunset))
            return cell

        case 1:
            cell.configureCell(text1: "CHANCE OF RAIN",
                               text2: "0%",
                               text3: "HUMIDITY",
                               text4: "\(humidity)%")
            return cell

        case 2:
            cell.configureCell(text1: "WIND",
                               text2: NSString(format:"%d kph", Int(windSpeed)) as String,
                               text3: "FEELS LIKE",
                               text4: NSString(format:"%d%@", Int(feelsLike),"\u{00B0}") as String)
            return cell

        case 3:
            cell.configureCell(text1: "PERCIPITATION",
                               text2: "0 cm",
                               text3: "PRESSURE",
                               text4: "\(pressure) hPa")
            return cell

        case 4:
            cell.configureCell(text1: "VISIBILITY",
                               text2: "\(visibility/1000) km",
                               text3: "UV INDEX",
                               text4: "0")
            return cell

        default:
            cell.configureCell(text1: nil, text2: nil, text3: nil, text4: nil)
            return cell

        }
    }
}
