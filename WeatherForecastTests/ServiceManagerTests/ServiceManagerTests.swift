//
//  ServiceManagerTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class ServiceManagerTests: XCTestCase {
    var sutProtocol: ServiceManagerProtocol!
    
    override func setUp() {
        super.setUp()
        sutProtocol = ServiceManager()
    }
    
    func testFetchResponse() {
        sutProtocol.fetchResponse(router: ForecastRouter.todayForecast(17.421700164463118, 78.51096064294487)) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response, "Response is nil, please check parsing data to json")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
    
    func testFetchCodable() {
        sutProtocol.fetchCodable(router: ForecastRouter.todayForecast(17.421700164463118, 78.51096064294487), codable: TodayForecastModel.self) { result in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model, "Model is nil, please check the request thoroughly")
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
}
