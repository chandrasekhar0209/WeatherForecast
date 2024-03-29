//
//  CityWeatherDetailsViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {
    var cityDetailsViewModel: CityDetailsProtocol
    @IBOutlet weak var todayWeatherView: UIView!
    @IBOutlet weak var weatherDetailsTable: UITableView!
    var todayForecast: TodayForecastModel!
    var weatherForecastList = [TodayForecastModel]()
    var dayWeatherList = [TodayForecastModel]()
    var bookmarkModel: BookmarkModel!

    lazy var weatherView: TodayWeatherView? = {
        guard let weatherView = UINib(nibName: TodayWeatherView.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? TodayWeatherView else {
            return nil
        }
        todayWeatherView.addSubview(weatherView)
        UIView.setEdgesConstraints(for: weatherView, with: todayWeatherView)
        weatherView.configureView(with: todayForecast)
        
        return weatherView
    }()

    init(cityDetailsViewModel: CityDetailsProtocol = CityDetailsViewModel()) {
        self.cityDetailsViewModel = cityDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cityDetailsViewModel = CityDetailsViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTodayForecast(router: .todayForecast(bookmarkModel.latitude, bookmarkModel.longitude))
        fetchFiveDayForecast(router: .fiveDayForecast(bookmarkModel.latitude, bookmarkModel.longitude))
    }
}

private extension CityWeatherDetailsViewController {
    func configureUI() {
        weatherDetailsTable.delegate = self
        weatherDetailsTable.dataSource = self
        registerCells()
        ActivityIndicator.shared.startAnimating(on: self.view)
    }
    
    func registerCells() {
        weatherDetailsTable.register(WeatherCollectionView.self, forCellReuseIdentifier: "\(WeatherCollectionView.self)")
        weatherDetailsTable.register(DayWeatherDetailsView.self, forCellReuseIdentifier: "\(DayWeatherDetailsView.self)")
        weatherDetailsTable.register(MoreDetailsView.self, forCellReuseIdentifier: "\(MoreDetailsView.self)")
    }
}

extension CityWeatherDetailsViewController {
    func fetchTodayForecast(router: ForecastRouter)  {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: TodayForecastModel.self) {[weak self] result in
            switch result {
            case .success(let model):
                guard let todayForecastModel = model as? TodayForecastModel else {
                    return
                }
                
                self?.todayForecast = todayForecastModel
                DispatchQueue.main.async {
                    self?.weatherView?.isHidden = false
                }
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func fetchFiveDayForecast(router: ForecastRouter) {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: FiveDayForecastModel.self) {[weak self] result in
            switch result {
            case .success(let model):
                guard let fiveDayForecastModel = model as? FiveDayForecastModel,
                      let list = fiveDayForecastModel.list else {
                    return
                }
                
                self?.weatherForecastList = list
                self?.dayWeatherList = list.filterDuplicates { a, b in
                    if let aWeatherList = a.weather,
                       let aWeather = aWeatherList.first,
                       let bWeatherList = b.weather,
                       let bWeather = bWeatherList.first {
                        return aWeather.id != bWeather.id
                    }
                    
                    return a.cityName != b.cityName
                }

                DispatchQueue.main.async {
                    self?.weatherDetailsTable.reloadData()
                    ActivityIndicator.shared.stopAnimating(on: (self?.view)!)
                }
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

extension CityWeatherDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 135.0
        case 1:
            return (CGFloat(dayWeatherList.count) * 60.0)/1.7
        default:
            return 270.0
        }
    }
}

extension CityWeatherDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCollectionView.identifier) as? WeatherCollectionView else {
                return UITableViewCell()
            }
            
            cell.weatherForecastList = weatherForecastList
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherDetailsView.identifier) as? DayWeatherDetailsView else {
                return UITableViewCell()
            }
            
            cell.weatherForecastList = dayWeatherList
            
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreDetailsView.identifier) as? MoreDetailsView else {
                return UITableViewCell()
            }
            
            cell.todayForecast = todayForecast
            
            return cell
        }
    }
}
