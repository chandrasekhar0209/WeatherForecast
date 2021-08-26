//
//  StorageManagerTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class StorageManagerTests: XCTestCase {
    var sut: StorageManagerProtocol!
    let mockRequest = ["cityName" : "Hyderabad",
                       "latitude": 12345.1234,
                       "longitude": 12345.1234] as [String : Any]
    override func setUp() {
        super.setUp()
        sut = StorageManager()
    }
    
    func testSaveRecord() {
        sut.saveRecord(forEntity: .bookmarks, with: mockRequest) { result in
            switch result {
            case .success(let string):
                XCTAssertNotNil(string, "Saving failed please check")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }

    func testFetchRecords() {
        sut.fetchRecords(forEntity: .bookmarks) { result in
            switch result {
            case .success(let objects):
                XCTAssertNotNil(objects, "List is empty")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
}
