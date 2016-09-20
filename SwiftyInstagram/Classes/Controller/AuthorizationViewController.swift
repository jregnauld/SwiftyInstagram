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
public protocol AuthorizationDelegate {
  func getWebViewAnswer(_ url:URL)
}
open class AuthorizationViewController: UIViewController, WKNavigationDelegate {
  let webView: WKWebView = WKWebView()
  let request: URLRequest
  open var delegate: AuthorizationDelegate?
  public init(_ coder: NSCoder? = nil, authorizationURL: URL) {
    self.request = URLRequest(url: authorizationURL)
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(nibName: nil, bundle:nil)
    }
  }
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.webView.load(request)
  }
  override open func viewDidLoad() {
    super.viewDidLoad()
    self.webView.navigationDelegate = self
    self.webView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.webView)
    if #available(iOS 9.0, *) {
      self.webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      self.webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      self.webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      self.webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    } else {
      // Fallback on earlier versions
      let views = ["webView": self.webView]
      let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|",
                                                                               options: [], metrics: nil, views: views)
      let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|",
                                                                               options: [], metrics: nil, views: views)
      NSLayoutConstraint.activate([verticalConstraints, horizontalConstraints].flatMap {$0})
    }
   
  }
  open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    print("didCommitNavigation")
  }
  open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("didFinishNavigation")
  }
  open func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    if let url = webView.url {
      self.getWebViewURL(url)
    }
  }
  open func getWebViewURL(_ url: URL) {
    self.delegate?.getWebViewAnswer(url)
  }
}
