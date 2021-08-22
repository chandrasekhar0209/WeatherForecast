//
//  BookmarkCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit

class BookmarkCell: UITableViewCell {
    @IBOutlet weak var bookMarkTitle: UILabel!
    static let identifier = "BookmarkCell"
    func configureCell(with data: BookmarkModel) {
        bookMarkTitle.text = data.cityName
    }
}
