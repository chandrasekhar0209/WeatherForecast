//
//  CityDetailsViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class CityDetailsViewModelTests: XCTestCase {

    var sut: CityDetailsProtocol!
    
    override func setUp() {
        super.setUp()
        
        sut = CityDetailsViewModel()
    }
    
    func testFetchCityForecast() {
        sut.fetchCityForecast(router: ForecastRouter.todayForecast(17.421700164463118, 78.51096064294487), codable: TodayForecastModel.self) { result in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model, "Model is nil, please check the request thoroughly")
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
}
