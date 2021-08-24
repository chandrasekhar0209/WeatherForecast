//
//  HelpViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebview()
    }
}

extension HelpViewController {
    func configureWebview() {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.loadHTMLString(getHtmlString(), baseURL: nil)
    }
    
    func getHtmlString() -> String {
        return "<html><body><center><span style=\"font-size:18px;font-weight:bold;\">Weather App</span></center><p>Weather App is used to get the accurate weather details of any city in the world. It gives you the Upcoming Five days forecast details including Today's. You can also bookmark your regular visiting cities and view the weather details in no time.<p><span style=\"font-size:18px;font-weight:bold;\">How to use?</span><ol><li>You can add or search your preffered city by tapping on '+' on top right of the Saved Cities Screen.</li><li>You will be redirected to New screen where you can see a Map with your current location pointed.</li><li>You can also check other cities by just searching on the search bar provided in the same screen.</li><li>You can bookmark the city by tapping on 'Bookmark' icon on top right.</li><li>In Saved cities screen you can see the list of saved cities and you can view the Weather forecast details on tapping on any city from the list.</li><li>You can also delete any city from the saved cities by tapping on 'Edit' and tapping the 'Delete' Icon.</li></ol></body></html>"
    }
}

extension HelpViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
