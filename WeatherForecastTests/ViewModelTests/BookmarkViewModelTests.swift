//
//  BookmarkViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Jakkidi Chandrasekhar Reddy on 26/08/21.
//

import XCTest
@testable import WeatherForecast

class BookmarkViewModelTests: XCTestCase {

    var sutSave: BookmarksSaveProtocol!
    var sutFetch: BookmarksFetchProtocol!
    let mockRequest = BookmarkModel(cityName: "Hyderabad", latitude: 123.345, longitude: 123.345)
    
    override func setUp() {
        super.setUp()
        sutSave = BookMarksViewModel()
        sutFetch = BookMarksViewModel()
    }
    
    func testSaveBookmark() {
        sutSave.saveBookMark(with: mockRequest) { result in
            switch result {
            case .success(let string):
                XCTAssertNotNil(string, "Saving failed please check")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
    
    func testFetchBookmark() {
        sutFetch.fetchAllSavedBookmarks { result in
            switch result {
            case .success(let objects):
                XCTAssertNotNil(objects, "List is empty")
            case .failure(let error):
                XCTAssertNotNil(error, "Error is empty")
            }
        }
    }
}
