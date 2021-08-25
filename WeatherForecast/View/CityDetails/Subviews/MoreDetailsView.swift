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
        return MoreDetailsCell.rowHeight
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
            cell.configureCell(text1: MoreDetailsViewConstants.sunrise.rawValue,
                               text2: Date.sunRiseTimeFormat(timeStamp: sunrise),
                               text3: MoreDetailsViewConstants.sunset.rawValue,
                               text4: Date.sunRiseTimeFormat(timeStamp: sunset))
            return cell

        case 1:
            cell.configureCell(text1: MoreDetailsViewConstants.chanceOfRain.rawValue,
                               text2: "\(MoreDetailsViewConstants.zeroValue.rawValue)\(WeatherSymbols.percentage.rawValue)",
                               text3: MoreDetailsViewConstants.humidity.rawValue,
                               text4: "\(humidity)\(WeatherSymbols.percentage.rawValue)")
            return cell

        case 2:
            cell.configureCell(text1: MoreDetailsViewConstants.wind.rawValue,
                               text2: NSString(format:"%d kph",
                                               Int(windSpeed)) as String,
                               text3: MoreDetailsViewConstants.feelsLike.rawValue,
                               text4: String.temparatureWithDegreeSymbol(value: "\(feelsLike)"))
            return cell

        case 3:
            cell.configureCell(text1: MoreDetailsViewConstants.percipitation.rawValue,
                               text2: "\(MoreDetailsViewConstants.zeroValue.rawValue) cm",
                               text3: MoreDetailsViewConstants.pressure.rawValue,
                               text4: "\(pressure) hPa")
            return cell

        case 4:
            cell.configureCell(text1: MoreDetailsViewConstants.visibility.rawValue,
                               text2: "\(visibility/1000) km",
                               text3: MoreDetailsViewConstants.uvIndex.rawValue,
                               text4: MoreDetailsViewConstants.zeroValue.rawValue)
            return cell

        default:
            cell.configureCell(text1: nil, text2: nil, text3: nil, text4: nil)
            return cell

        }
    }
}

enum MoreDetailsViewConstants: String {
    case sunrise = "SUNRISE"
    case sunset = "SUNSET"
    case chanceOfRain = "CHANCE OF RAIN"
    case humidity = "HUMIDITY"
    case wind = "WIND"
    case feelsLike = "FEELS LIKE"
    case percipitation = "PERCIPITATION"
    case pressure = "PRESSURE"
    case visibility = "VISIBILITY"
    case uvIndex = "UV INDEX"
    case zeroValue = "0"
}
