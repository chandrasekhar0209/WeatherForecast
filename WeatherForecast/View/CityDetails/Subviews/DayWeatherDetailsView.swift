//
//  DayWeatherDetailsView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class DayWeatherDetailsView: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "DayWeatherDetailsView"
    static let nibName = "DayWeatherDetailsView"
    var weatherForecastList = [TodayForecastModel]()
    func configureCell(with list: [TodayForecastModel]) {
        weatherForecastList = list
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DayDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: DayDetailsCell.identifier)
        tableView.reloadData()
    }
}

extension DayWeatherDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
}

extension DayWeatherDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayDetailsCell.identifier) as? DayDetailsCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: weatherForecastList[indexPath.row])
        
        return cell
    }
}
