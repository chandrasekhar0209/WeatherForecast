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

    func configureCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.register(UINib(nibName: MoreDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: MoreDetailsCell.identifier)
    }
}

extension MoreDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension MoreDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreDetailsCell.identifier) as? MoreDetailsCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
