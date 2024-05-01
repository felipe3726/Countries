//
//  WebView.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import UIKit
import WebKit

class WebView: UIViewController, WKNavigationDelegate {
    var country: CountryInfo?
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "https://www.google.com.mx/maps/place/México")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
