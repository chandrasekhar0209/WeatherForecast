//
//  GenericCollectionViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import UIKit

class GenericCollectionViewController<T, Cell: UICollectionViewCell>: UICollectionViewController {
    var items: [T]
    var configure: (Cell, T, Int) -> Void
    var selectHandler: (T) -> Void
    var isDefaultCell: Bool = false
    init(items: [T], isDefaultCell: Bool, layout: UICollectionViewLayout, configure: @escaping (Cell, T, Int) -> Void, selectHandler: @escaping (T) -> Void) {
        self.items = items
        self.isDefaultCell = isDefaultCell
        self.configure = configure
        self.selectHandler = selectHandler
        super.init(collectionViewLayout: layout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        if isDefaultCell {
            self.collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        } else {
            self.collectionView.register(UINib(nibName: "\(Cell.self)", bundle: nil), forCellWithReuseIdentifier: "\(Cell.self)")
        }
    }
    
    func updatesItems(items: [T]) {
        self.items = items
        self.collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = isDefaultCell ? "Cell" : "\(Cell.self)"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        configure(cell, item, indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectHandler(item)
    }
}
