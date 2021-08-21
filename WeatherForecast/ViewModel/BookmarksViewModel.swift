//
//  BookmarksViewModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import Foundation

protocol BookmarksProtocol {
    func saveBookMark(with data: BookmarkModel, completion: (StorageResult<String, Error>) -> Void)
    func fetchAllSavedBookmarks(completion: (StorageResult<[BookmarkModel], Error>) -> Void)
}

class BookMarksViewModel {
    var storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol = StorageManager()) {
        self.storageManager = storageManager
    }
}

extension BookMarksViewModel: BookmarksProtocol {
    func saveBookMark(with data: BookmarkModel, completion: (StorageResult<String, Error>) -> Void) {
        var bookmarkData = [String: Any]()
        bookmarkData[BookmarkEntityKeys.cityName.rawValue] = data.cityName
        bookmarkData[BookmarkEntityKeys.latitude.rawValue] = data.latitude
        bookmarkData[BookmarkEntityKeys.longitude.rawValue] = data.longitude
        storageManager.saveRecord(forEntity: .bookmarks, with: bookmarkData) { result in
            completion(result)
        }
    }
    
    func fetchAllSavedBookmarks(completion: (StorageResult<[BookmarkModel], Error>) -> Void) {
        storageManager.fetchRecords(forEntity: .bookmarks) { result in
            switch result {
            case .success(let managedObjects):
                guard let bookmarkObjects = managedObjects as? [BookmarkModel] else {
                    completion(.success([BookmarkModel]()))
                    return
                }
                
                completion(.success(bookmarkObjects))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
