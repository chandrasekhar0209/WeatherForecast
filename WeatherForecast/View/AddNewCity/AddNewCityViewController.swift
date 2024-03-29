//
//  AddNewCityViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddNewCityViewController: UIViewController {
    let locationManager = CLLocationManager()
    var citySearchController: UISearchController? = nil
    var citySearchTable: CitySearchTable?
    @IBOutlet weak var mapView: MKMapView!
    var coordinate: CLLocationCoordinate2D? = nil
    var selectedCity: String?
    var bookmarksViewModel: BookmarksSaveProtocol
    
    init(bookmarkViewModel: BookmarksSaveProtocol = BookMarksViewModel()) {
        self.bookmarksViewModel = bookmarkViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.bookmarksViewModel = BookMarksViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        ActivityIndicator.shared.startAnimating(on: self.view)
    }
}

private extension AddNewCityViewController {
    func configureUI() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(saveButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        configureLocationManager()
        configureCitySearchTable()
        configureSearchController()
    }
    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
    }
    
    func configureCitySearchTable() {
        citySearchTable = CitySearchTable(mapView: mapView, delegate: self)
    }
    
    func configureSearchController() {
        guard let cityTable = citySearchTable else {
            return
        }
        
        citySearchController = UISearchController(searchResultsController: cityTable)
        citySearchController?.searchResultsUpdater = cityTable
        let searchBar = citySearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = citySearchController
        citySearchController?.hidesNavigationBarDuringPresentation = false
        citySearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    func setMapRegion<M: CLPlacemark>(placemark: M) {
        if let location = placemark.location?.coordinate {
            coordinate = location
            selectedCity = placemark.locality
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = placemark.name
            if let state = placemark.administrativeArea,
               let country = placemark.country {
                annotation.subtitle = "\(state) \(country)"
            }
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension AddNewCityViewController {
    @objc func saveButtonTapped(sender: UIBarButtonItem) {
        guard let cityCoordinates = coordinate, let city = selectedCity else {
            return
        }
        let bookmarkModel = BookmarkModel(cityName: city, latitude: cityCoordinates.latitude, longitude: cityCoordinates.longitude)
        bookmarksViewModel.saveBookMark(with: bookmarkModel) { result in
            switch result {
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            case .failure(_):
                break
            }
        }
    }
}

extension AddNewCityViewController : CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            locationManager.stopUpdatingLocation()

        case .authorizedAlways:
            locationManager.requestLocation()
            locationManager.stopUpdatingLocation()

        default:
            print("Location")
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ActivityIndicator.shared.stopAnimating(on: self.view)
        guard let location = locations.first else {
            return
        }

        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) {[weak self] placemarks, error in
            if let placemarks = placemarks,
               let placemark = placemarks.first {
                self?.setMapRegion(placemark: placemark)
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension AddNewCityViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark){
        setMapRegion(placemark: placemark)
    }
}
