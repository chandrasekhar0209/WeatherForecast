//
//  BookmarksViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tableSubView: UIView!
    var bookmarkViewModel: BookmarksFetchProtocol
    var bookmarks = [NSManagedObject]() {
        didSet {
            tableController.updatesItems(items: bookmarks)
        }
    }

    var tableController: GenericTableViewController<NSManagedObject, BookmarkCell>!
    
    lazy var errorView: ErrorView? = {
        guard let errorView = UINib(nibName: ErrorView.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ErrorView else {
            return nil
        }
        self.view.addSubview(errorView)
        UIView.setCenterConstraints(for: errorView, with: self.view)
        let properties = ErrorProperties(imageName: "bookmark.slash.fill", message: "No saved cities")
        errorView.configureView(with: properties)
        
        return errorView
    }()
    
    init(bookmarkViewModel: BookmarksFetchProtocol = BookMarksViewModel()) {
        self.bookmarkViewModel = bookmarkViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.bookmarkViewModel = BookMarksViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ActivityIndicator.shared.startAnimating(on: self.view)
        fetchBookmarks()
    }
}

extension BookmarksViewController {
    func editTable() {
        tableController.tableView.isEditing = !tableController.tableView.isEditing
    }
}

private extension BookmarksViewController {
    func configureController() {
        let tableProperties = TableProperties(rowHeight: 60.0)
        tableController = GenericTableViewController(items: bookmarks, tableProperties: tableProperties, isDefaultCell: false, configure: { (cell: BookmarkCell, bookmark, index) in
            cell.configureCell(with: bookmark)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        }, selectHandler: {[weak self] model in
            self?.moveToNextPage(model: model)
        }, editHandler: {[weak self] index in
            self?.deleteRecord(index: index)
        })
        tableSubView.addSubview(tableController.tableView)
        UIView.setEdgesConstraints(for: tableController.tableView, with: tableSubView)
    }
    
    func fetchBookmarks() {
        bookmarkViewModel.fetchAllSavedBookmarks { result in
            switch result {
            case .success(let bookmarks):
                self.bookmarks = bookmarks
                processNextStep()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteBookmark(_ bookmark: NSManagedObject) {
        bookmarkViewModel.deleteBookMark(bookmark) { result in
            switch result {
            case .success(_):
                fetchBookmarks()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func processNextStep() {
        guard let view = errorView else {
            return
        }
        view.isHidden = bookmarks.count > 0 ? true : false
        tableController.tableView.isHidden = !view.isHidden
        ActivityIndicator.shared.stopAnimating(on: self.view)
        reloadData()
    }
    
    func reloadData() {
        tableController.tableView.reloadData()
    }
    
    func moveToNextPage(model: NSManagedObject) {
        let cityDetails: StoryboardProtocol = CityWeatherDetailsViewController()
        guard let cityName = model.value(forKey: BookmarkEntityKeys.cityName.rawValue) as? String,
              let latitude = model.value(forKey: BookmarkEntityKeys.latitude.rawValue) as? Double,
              let longitude = model.value(forKey: BookmarkEntityKeys.longitude.rawValue) as? Double,
              let viewController = cityDetails.instantiateControllerFromStoryboard() as? CityWeatherDetailsViewController else {
            return
        }
        let bookMarkModel = BookmarkModel(cityName: cityName, latitude: latitude, longitude: longitude)
        viewController.bookmarkModel = bookMarkModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func deleteRecord(index: Int) {
        let bookmarkObject = bookmarks[index]
        bookmarks.remove(at: index)
        let indexpath = IndexPath(item: index, section: 0)
        tableController.tableView.deleteRows(at: [indexpath], with: .fade)
        deleteBookmark(bookmarkObject)
    }
}
