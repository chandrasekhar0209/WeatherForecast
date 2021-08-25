//
//  MoreDetailsCell.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class MoreDetailsCell: UITableViewCell {
    static let identifier = "MoreDetailsCell"
    static let nibName = "MoreDetailsCell"
    static let rowHeight: CGFloat = 50.0
    @IBOutlet weak var moreLabel1: UILabel!
    @IBOutlet weak var moreLabel2: UILabel!
    @IBOutlet weak var moreLabel3: UILabel!
    @IBOutlet weak var moreLabel4: UILabel!

    func configureCell(text1: String?, text2: String?, text3: String?, text4: String?) {
        moreLabel1.text = text1
        moreLabel2.text = text2
        moreLabel3.text = text3
        moreLabel4.text = text4
    }
}
