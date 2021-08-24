//
//  BookmarkCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit
import CoreData

class BookmarkCell: UITableViewCell {
    @IBOutlet weak var bookMarkTitle: UILabel!
    static let identifier = "BookmarkCell"
    static let nibName = "BookmarkCell"
    func configureCell(with data: NSManagedObject) {
        guard let cityName = data.value(forKey: BookmarkEntityKeys.cityName.rawValue) as? String else {
            return
        }
        bookMarkTitle.text = cityName
    }
}
