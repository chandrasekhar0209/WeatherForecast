//
//  BookmarksViewModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import Foundation
import CoreData

protocol BookmarksSaveProtocol {
    func saveBookMark(with data: BookmarkModel, completion: (StorageResult<String, Error>) -> Void)
}

protocol BookmarksFetchProtocol {
    func fetchAllSavedBookmarks(completion: (StorageResult<ManagedObjects, Error>) -> Void)
    func deleteBookMark(_ data: NSManagedObject, completion: (StorageResult<String, Error>) -> Void)
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
    func fetchAllSavedBookmarks(completion: (StorageResult<ManagedObjects, Error>) -> Void) {
        storageManager.fetchRecords(forEntity: .bookmarks) { result in
            completion(result)
        }
    }
    
    func deleteBookMark(_ data: NSManagedObject, completion: (StorageResult<String, Error>) -> Void) {
        storageManager.deleteRecord(model: data) { result in
            completion(result)
        }
    }
}
