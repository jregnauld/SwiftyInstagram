//
//  AuthorizationViewController.swift
//  Pods
//
//  Created by Julien Regnauld on 8/11/16.
//
//

import Foundation
import UIKit
import WebKit

class AuthorizationViewController: UIViewController, WKNavigationDelegate {
  let webView: WKWebView = WKWebView()
  let request: NSURLRequest
  internal init(_ coder: NSCoder? = nil, authorizationURL: NSURL) {
    print(authorizationURL)
    self.request = NSURLRequest(URL: authorizationURL)
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(nibName: nil, bundle:nil)
    }
  }
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.webView.loadRequest(request)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.webView.navigationDelegate = self
    self.webView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.webView)
    self.webView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    self.webView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    self.webView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
    self.webView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
  }
  func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    print("didCommitNavigation")
  }
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    print("didFinishNavigation")
  }
  func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    print("didReceiveServerRedirectForProvisionalNavigation")
    print(webView.URL)
  }
}