//
//  BookmarksViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController {
    @IBOutlet weak var bookmarkTableView: UITableView!
    var bookmarkViewModel: BookmarksFetchProtocol
    var bookmarks = [NSManagedObject]()
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
        bookmarkTableView.isEditing = !bookmarkTableView.isEditing
    }
}

private extension BookmarksViewController {
    func configureController() {
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        bookmarkTableView.register(UINib(nibName: BookmarkCell.nibName, bundle: nil), forCellReuseIdentifier: BookmarkCell.identifier)
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
        bookmarkTableView.isHidden = !view.isHidden
        ActivityIndicator.shared.stopAnimating(on: self.view)
        reloadData()
    }
    
    func reloadData() {
        bookmarkTableView.reloadData()
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = bookmarks[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookmarkObject = bookmarks[indexPath.row]
            bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteBookmark(bookmarkObject)
        }
    }
}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookmarkModel = bookmarks[indexPath.row]
        guard let cell: BookmarkCell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.identifier) as? BookmarkCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: bookmarkModel)
        cell.selectionStyle = .none
        return cell
    }
}
