//
//  BookmarksViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit

class BookmarksViewController: UIViewController {
    @IBOutlet weak var bookmarkTableView: UITableView!
    var bookmarkViewModel: BookmarksProtocol
    var bookmarks = [BookmarkModel]()
    lazy var errorView: ErrorView? = {
        guard let errorView = UINib(nibName: ErrorView.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ErrorView else {
            return nil
        }
        self.view.addSubview(errorView)
        errorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        let properties = ErrorProperties(imageName: "bookmark.slash.fill", message: "No saved cities")
        errorView.configureView(with: properties)
        
        return errorView
    }()
    
    init(bookmarkViewModel: BookmarksProtocol = BookMarksViewModel()) {
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
}

private extension BookmarksViewController {
    func configureController() {
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        fetchBookmarks()
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
    
    func processNextStep() {
        guard let view = errorView else {
            return
        }
        view.isHidden = bookmarks.count > 0 ? true : false
        bookmarkTableView.isHidden = !view.isHidden
        reloadData()
    }
    
    func reloadData() {
        bookmarkTableView.reloadData()
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmarkModel = bookmarks[indexPath.row]
        print(bookmarkModel.cityName)
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
        return cell
    }
}
