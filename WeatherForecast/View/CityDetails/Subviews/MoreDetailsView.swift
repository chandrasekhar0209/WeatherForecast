//
//  MoreDetailsView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class MoreDetailsView: UITableViewCell {
    static let identifier = "MoreDetailsView"
    static let nibName = "MoreDetailsView"
    var tableController: GenericTableViewController<Int, MoreDetailsCell>!
    let list = [1,2,3,4,5]
    var todayForecast : TodayForecastModel! {
        didSet {
            tableController.updatesItems(items: list)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell() {
        let tableProperties = TableProperties(rowHeight: MoreDetailsCell.rowHeight)
        tableController = GenericTableViewController(items: [], tableProperties: tableProperties, configure: {[weak self] (cell: MoreDetailsCell, _, index) in
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            guard self?.todayForecast != nil,
                  let sunrise = self?.todayForecast.system?.sunrise,
                  let sunset = self?.todayForecast.system?.sunset,
                  let humidity = self?.todayForecast.main?.humidity,
                  let windSpeed = self?.todayForecast.wind?.speed,
                  let feelsLike = self?.todayForecast.main?.feelsLike,
                  let pressure = self?.todayForecast.main?.pressure,
                  let visibility = self?.todayForecast.visibility else {
                return
            }

            switch index {
            case 0:
                cell.configureCell(text1: MoreDetailsViewConstants.sunrise.rawValue,
                                   text2: Date.sunRiseTimeFormat(timeStamp: sunrise),
                                   text3: MoreDetailsViewConstants.sunset.rawValue,
                                   text4: Date.sunRiseTimeFormat(timeStamp: sunset))
            case 1:
                cell.configureCell(text1: MoreDetailsViewConstants.chanceOfRain.rawValue,
                                   text2: "\(MoreDetailsViewConstants.zeroValue.rawValue)\(WeatherSymbols.percentage.rawValue)",
                                   text3: MoreDetailsViewConstants.humidity.rawValue,
                                   text4: "\(humidity)\(WeatherSymbols.percentage.rawValue)")
            case 2:
                cell.configureCell(text1: MoreDetailsViewConstants.wind.rawValue,
                                   text2: NSString(format:"%d kph",
                                                   Int(windSpeed)) as String,
                                   text3: MoreDetailsViewConstants.feelsLike.rawValue,
                                   text4: String.temparatureWithDegreeSymbol(value: "\(feelsLike)"))
            case 3:
                cell.configureCell(text1: MoreDetailsViewConstants.percipitation.rawValue,
                                   text2: "\(MoreDetailsViewConstants.zeroValue.rawValue) cm",
                                   text3: MoreDetailsViewConstants.pressure.rawValue,
                                   text4: "\(pressure) hPa")
            case 4:
                cell.configureCell(text1: MoreDetailsViewConstants.visibility.rawValue,
                                   text2: "\(visibility/1000) km",
                                   text3: MoreDetailsViewConstants.uvIndex.rawValue,
                                   text4: MoreDetailsViewConstants.zeroValue.rawValue)
            default:
                cell.configureCell(text1: nil, text2: nil, text3: nil, text4: nil)
            }

        }, selectHandler: { _ in }, editHandler: { _ in })
        self.addSubview(tableController.tableView)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        UIView.setEdgesConstraints(for: tableController.tableView, with: self)
        tableController.tableView.layer.borderColor = UIColor.white.cgColor
        tableController.tableView.layer.borderWidth = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableController.tableView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
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
