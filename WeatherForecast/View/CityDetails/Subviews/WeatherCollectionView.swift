//
//  WeatherCollectionView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class WeatherCollectionView: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "WeatherCollectionView"
    static let nibName = "WeatherCollectionView"

    func configureCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.layer.borderWidth = 0.5
        collectionView.register(UINib(nibName: WeatherCell.nibName, bundle: nil), forCellWithReuseIdentifier: WeatherCell.identifier)
        setLayout()
    }
}

extension WeatherCollectionView {
    func setLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        layout.itemSize = WeatherCell.cellSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
}

extension WeatherCollectionView: UICollectionViewDelegate {
    
}

extension WeatherCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .clear
        return cell
    }
}
