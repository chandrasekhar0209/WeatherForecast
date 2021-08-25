//
//  DayWeatherDetailsView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class DayWeatherDetailsView: UITableViewCell {
    static let identifier = "DayWeatherDetailsView"
    static let nibName = "DayWeatherDetailsView"
    var tableController: GenericTableViewController<TodayForecastModel, DayDetailsCell>!
    var weatherForecastList = [TodayForecastModel]() {
        didSet {
            tableController.updatesItems(items: weatherForecastList)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell(with: weatherForecastList)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with list: [TodayForecastModel]) {
        let tableProperties = TableProperties(rowHeight: DayDetailsCell.rowHeight)
        tableController = GenericTableViewController(items: list, tableProperties: tableProperties) { (cell: DayDetailsCell, todayForecast, index)  in
            cell.configureCell(with: todayForecast)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        } selectHandler: { _ in } editHandler: { _ in }
        
        self.addSubview(tableController.tableView)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        UIView.setEdgesConstraints(for: tableController.tableView, with: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableController.tableView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
    }
}
