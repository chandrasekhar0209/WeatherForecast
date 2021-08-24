//
//  BookmarksViewModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import Foundation

protocol BookmarksSaveProtocol {
    func saveBookMark(with data: BookmarkModel, completion: (StorageResult<String, Error>) -> Void)
}

protocol BookmarksFetchProtocol {
    func fetchAllSavedBookmarks(completion: (StorageResult<[BookmarkModel], Error>) -> Void)
}

class BookMarksViewModel {
    var storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol = StorageManager()) {
        self.storageManager = storageManager
    }
}

extension BookMarksViewModel: BookmarksSaveProtocol {
    func saveBookMark(with data: BookmarkModel, completion: (StorageResult<String, Error>) -> Void) {
        var bookmarkData = [String: Any]()
        bookmarkData[BookmarkEntityKeys.cityName.rawValue] = data.cityName
        bookmarkData[BookmarkEntityKeys.latitude.rawValue] = data.latitude
        bookmarkData[BookmarkEntityKeys.longitude.rawValue] = data.longitude
        storageManager.saveRecord(forEntity: .bookmarks, with: bookmarkData) { result in
            completion(result)
        }
    }
}

extension BookMarksViewModel: BookmarksFetchProtocol {
    func fetchAllSavedBookmarks(completion: (StorageResult<[BookmarkModel], Error>) -> Void) {
        storageManager.fetchRecords(forEntity: .bookmarks) { result in
            switch result {
            case .success(let managedObjects):
                var bookmarkObjects = [BookmarkModel]()
                managedObjects.forEach { managedObject in
                    if let city = managedObject.value(forKey: BookmarkEntityKeys.cityName.rawValue) as? String,
                       let latitude = managedObject.value(forKey: BookmarkEntityKeys.latitude.rawValue) as? Double,
                       let longitude = managedObject.value(forKey: BookmarkEntityKeys.longitude.rawValue) as? Double {
                        let bookmarkModel = BookmarkModel(cityName: city, latitude: latitude, longitude: longitude)
                        bookmarkObjects.append(bookmarkModel)
                    }
                }
                
                completion(.success(bookmarkObjects))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
