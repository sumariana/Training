//
//  WebViewController.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {
    
    var url: String = ""
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }

}
