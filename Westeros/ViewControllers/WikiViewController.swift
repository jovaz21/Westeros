//
//  WikiViewController.swift
//  Westeros
//
//  Created by ATEmobile on 15/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit
import WebKit

// MARK: - Controller Stuff
class WikiViewController: UIViewController {
    var model: House
    
    // MARK: - Init
    init(model: House) {
        
        /* set */
        self.model = model
        
        /* set */
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        self.title = "Wiki"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // View Is Loaded:
    // Setup UIView Layer
    override func viewDidLoad() { super.viewDidLoad()
        self.setupUIView()
    }
    
    // View Will Appear:
    //  - Makes UIView Display/Paint WikiViewData
    //  - Adds Observer to HouseListViewController's HOUSEDIDCHANGE_NOTIFICATION
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        
        /* set */
        self.setUIViewData(WikiViewData(wikiURL: model.wikiURL))
        
        // Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: HouseListViewController.HOUSEDIDCHANGE_NOTIFICATION, object: nil)
    }
    @objc func houseDidChange(notification: Notification) {
        
        /* check */
        guard let userInfo = notification.userInfo else {
            return
        }
        
        /* set */
        let newModel = userInfo[HouseListViewController.HOUSE_KEY] as! House
        
        /* check */
        if (newModel == self.model) {
            return
        }
        
        /* set */
        self.model = newModel
        
        /* set */
        self.setUIViewData(WikiViewData(wikiURL: self.model.wikiURL))
    }

    // View Will Disappear:
    // Remove Observer
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Outlets for View Stuff
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// MARK: - View Stuff
struct WikiViewData {
    let wikiURL: URL
}
extension WikiViewController: WKNavigationDelegate {
    
    // Setup UIView:
    // Makes WikiViewController WebView's WKNavigationDelegate
    func setupUIView() { wkWebView.navigationDelegate = self }
    
    // Set UIView Data:
    //  - Starts animating the Activity Indicator
    //  - Makes WebView Loading the Wiki Page URL
    func setUIViewData(_ data: WikiViewData) {
        
        /* set */
        activityIndicator.hidesWhenStopped  = true
        activityIndicator.isHidden          = false
        activityIndicator.startAnimating()
        
        /* load */
        wkWebView.load(URLRequest(url: data.wikiURL))
    }
    
    // WKNavigation Delegate Functions:
    //  - Stop Animating the Activity Indicator when URL Loading is Finished
    //  - Cancel/Prevent any LINK and FORM SUBMIT Navigation Action
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        switch(navigationAction.navigationType) {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
