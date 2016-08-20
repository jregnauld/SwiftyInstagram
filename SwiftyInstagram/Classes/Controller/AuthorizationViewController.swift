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
protocol AuthorizationDelegate {
  func getWebViewAnswer(url:NSURL)
}
public class AuthorizationViewController: UIViewController, WKNavigationDelegate {
  let webView: WKWebView = WKWebView()
  let request: NSURLRequest
  var delegate: AuthorizationDelegate?
  public init(_ coder: NSCoder? = nil, authorizationURL: NSURL) {
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
  override public func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.webView.loadRequest(request)
  }
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.webView.navigationDelegate = self
    self.webView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.webView)
    if #available(iOS 9.0, *) {
      self.webView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
      self.webView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
      self.webView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
      self.webView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    } else {
      // Fallback on earlier versions
      let views = ["webView": self.webView]
      let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|",
                                                                               options: [], metrics: nil, views: views)
      let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|",
                                                                               options: [], metrics: nil, views: views)
      NSLayoutConstraint.activateConstraints([verticalConstraints, horizontalConstraints].flatMap {$0})
    }
   
  }
  public func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    print("didCommitNavigation")
  }
  public func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    print("didFinishNavigation")
  }
  public func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    if let url = webView.URL {
      self.getWebViewURL(url)
    }
  }
  public func getWebViewURL(url: NSURL) {
    self.delegate?.getWebViewAnswer(url)
  }
}