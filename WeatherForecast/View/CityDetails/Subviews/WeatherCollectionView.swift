//
//  WeatherCollectionView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class WeatherCollectionView: UITableViewCell {
    static let identifier = "WeatherCollectionView"
    static let nibName = "WeatherCollectionView"
    var collectionController: GenericCollectionViewController<TodayForecastModel, WeatherCell>!
    var weatherForecastList = [TodayForecastModel]() {
        didSet {
            collectionController.updatesItems(items: weatherForecastList)
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
        collectionController = GenericCollectionViewController(items: list, isDefaultCell: false, layout: setLayout(), configure: { (cell: WeatherCell, todayForecast, index) in
            
        }, selectHandler: { _ in })
        self.addSubview(collectionController.collectionView)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        collectionController.collectionView.layer.borderColor = UIColor.white.cgColor
        collectionController.collectionView.layer.borderWidth = 0.5
        UIView.setEdgesConstraints(for: collectionController.collectionView, with: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionController.collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
    }
}

extension WeatherCollectionView {
    func setLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        layout.itemSize = WeatherCell.cellSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return layout
    }
}
