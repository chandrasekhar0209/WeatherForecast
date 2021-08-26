//
//  NetworkClientTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class NetworkClientTests: XCTestCase {
    var sut : NetworkClientProtocol!
    
    override func setUp() {
        super.setUp()
        sut = NetworkClient()
    }
    
    func testNetworkRequest() {
        sut.request(router: ForecastRouter.todayForecast(17.421700164463118, 78.51096064294487)) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data is empty, please check request thoroughly")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
}
