//
//  ViewController.swift
//  PullToRefreshWebView
//
//  Created by Caitlin on 9/19/18.
//  Copyright © 2018 Caitlin. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        setupWebView()
        
    }

    // Commented out another setupWebView function example below
    func setupWebView() {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: view.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        
        // Set constraints on webview
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
        
        webView.uiDelegate = self
        
        // pull to refresh
        webView.scrollView.bounces = true
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshWebView), for: UIControlEvents.valueChanged)
        webView.scrollView.addSubview(refreshControl)
        
        self.openUrl()
    }
    
    @objc func refreshWebView(sender: UIRefreshControl) {
        print("refersh")
        print(sender)
        sender.endRefreshing()
        webView.reload()
    }
    
    
    func openUrl() {
        let url = URL (string: "https://www.apple.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    
    // With two subviews - UIView with a webview
    //    func setupWebView() {
    //        let webViewContainer = UIView()
    //        webViewContainer.translatesAutoresizingMaskIntoConstraints = false
    //        let statusBarHeight = UIApplication.shared.statusBarFrame.height
    //
    //        view.addSubview(webViewContainer)
    //        NSLayoutConstraint.activate([
    //            webViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
    //            webViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
    //            webViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight),
    //            webViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
    //        ])
    //
    //        let webConfiguration = WKWebViewConfiguration()
    //
    //        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: webViewContainer.frame.size.height))
    //        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
    //        webView.translatesAutoresizingMaskIntoConstraints = false
    //        webViewContainer.addSubview(webView)
    //        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
    //        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
    //        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
    //        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
    //        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
    //
    //        webView.uiDelegate = self
    //        webView.scrollView.bounces = false
    //        self.openUrl()
    //    }

    
    
}

