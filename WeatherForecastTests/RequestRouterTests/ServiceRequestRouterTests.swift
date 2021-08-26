//
//  ServiceRequestRouterTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class ServiceRequestRouterTests: XCTestCase {
    var sut: ServiceRequestRouter!
    
    override func setUp() {
        sut = MockRouter()
    }
    
    func testSuccessServiceRequestRouter() {
        XCTAssertNotNil(sut.path, "Path should not be nil")
        XCTAssertEqual(try sut.asURL().absoluteString, "http://api.openweathermap.org/data/2.5/weather?appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric", "URL is invalid.")
        XCTAssertNotNil(sut.methodType, "HTTP method type is mandatory")
        XCTAssertNotNil(sut.headers, "Headers should not be empty")
        XCTAssertNotNil(sut.queryItems, "QueryItems should not be empty")
    }
    
    func testFailureServiceRequestRouter() {
        XCTAssertNotEqual(sut.path, "", "Path should not be empty")
        XCTAssertNotEqual(try sut.asURL().absoluteString, "http://api.openweathermap.org/data/2.5/weather?", "URL is invalid.")
        XCTAssertNotEqual(sut.methodType.rawValue, "", "HTTP method type is invalid")
        XCTAssertNotEqual(sut.headers, [:], "Headers should not be empty")
    }
}

struct MockRouter: ServiceRequestRouter {
    var path: String = "/data/2.5/weather"
    var methodType: HTTPMethod = .get
    var body: Parameters? = [String: Any]()
    var headers: HTTPHeaders = ["String": "String"]
    var queryItems: QueryItems = [String: Any]()
}
