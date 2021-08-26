//
//  HelpViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var unitsSegment: UISegmentedControl!
    var bookmarkViewModel: BookmarksFetchProtocol = BookMarksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.shared.startAnimating(on: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureWebview()
    }
}

extension HelpViewController {
    func configureWebview() {
        let webKitView = WKWebView(frame: CGRect(x: 0, y: 0, width: webView.frame.size.width, height: webView.frame.size.height))
        webView.addSubview(webKitView)
        webKitView.navigationDelegate = self
        webKitView.loadHTMLString(getHtmlString(), baseURL: nil)
        unitsSegment.selectedSegmentIndex = UserDefaultsStorage.shared.units as! String == Units.metric.rawValue ? 0 : 1
    }
    
    func getHtmlString() -> String {
        return "<html><body><center><span style=\"font-size:18px;font-weight:bold;\">Weather App</span></center><p>Weather App is used to get the accurate weather details of any city in the world. It gives you the Upcoming Five days forecast details including Today's. You can also bookmark your regular visiting cities and view the weather details in no time.<p><span style=\"font-size:18px;font-weight:bold;\">How to use?</span><ol><li>You can add or search your preffered city by tapping on '+' on top right of the Saved Cities Screen.</li><li>You will be redirected to New screen where you can see a Map with your current location pointed.</li><li>You can also check other cities by just searching on the search bar provided in the same screen.</li><li>You can bookmark the city by tapping on 'Bookmark' icon on top right.</li><li>In Saved cities screen you can see the list of saved cities and you can view the Weather forecast details on tapping on any city from the list.</li><li>You can also delete any city from the saved cities by tapping on 'Edit' and tapping the 'Delete' Icon.</li></ol></body></html>"
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaultsStorage.shared.units = Units.metric.rawValue
        case 1:
            UserDefaultsStorage.shared.units = Units.imperial.rawValue
        default:
            break
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        bookmarkViewModel.deleteAllSavedBookmarks { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}

extension HelpViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicator.shared.stopAnimating(on: self.view)
    }
}

enum Units: String {
    case metric
    case imperial
}
