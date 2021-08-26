//
//  CitySearchTable.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import UIKit
import MapKit

class CitySearchTable: UITableViewController {
    var matchingItems = [MKMapItem]() {
        didSet {
            genericTableController.updatesItems(items: matchingItems)
        }
    }
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate:HandleMapSearch? = nil
    static let identifier = "SearchedCityName"
    var genericTableController: GenericTableViewController<MKMapItem, UITableViewCell>!
    
    init(mapView: MKMapView, delegate: HandleMapSearch) {
        self.mapView = mapView
        self.handleMapSearchDelegate = delegate
        super.init(style: .plain)
        configureTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CitySearchTable {
    func configureTable() {
        genericTableController = GenericTableViewController(items: matchingItems, isDefaultCell: true, configure: { (cell: UITableViewCell, matchinItem, index) in
            cell.textLabel?.text = matchinItem.placemark.name
        }, selectHandler: {[weak self] matchingItem in
            self?.handleMapSearchDelegate?.dropPinZoomIn(placemark: matchingItem.placemark)
            self?.dismiss(animated: true, completion: nil)
        }, editHandler: { _ in })
        addChildViewController()
    }
    
    func addChildViewController() {
        self.addChild(genericTableController)
        self.view.addSubview(genericTableController.view)
        genericTableController.didMove(toParent: self)
    }
}

extension CitySearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
        }
    }
}
