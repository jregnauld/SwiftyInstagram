//
//  LoginManager.swift
//  Pods
//
//  Created by Julien Regnauld on 8/11/16.
//
//

import Foundation
public typealias InstagramAuthorizationHandler = ((result: AuthorizationResult) -> Void)
public enum AuthorizationResult {
  case Success()
  case Failure()
}
public class LoginManager: AuthorizationDelegate {
  private let _session: Session
  private let _authorizationViewController: AuthorizationViewController
  private var _authorizationHandler: InstagramAuthorizationHandler?
  public init(session: Session = Session.sharedSession(), authorizationViewController: AuthorizationViewController? = nil) {
    self._session = session
    if let authorizationViewController = authorizationViewController {
      self._authorizationViewController = authorizationViewController
    } else {
      self._authorizationViewController = AuthorizationViewController(authorizationURL: self._session.authorizationURL)
    }
    self._authorizationViewController.delegate = self
  }
  public func loginFromViewController(viewController: UIViewController, completed: InstagramAuthorizationHandler) {
    self._authorizationHandler = completed
    let navigationController = UINavigationController(rootViewController: self._authorizationViewController)
    viewController.presentViewController(navigationController, animated: true, completion: nil)
  }
  public func getWebViewAnswer(url: NSURL) {
    self.checkAnswer(url) { (result) in
      self._authorizationHandler!(result: result)
    }
  }
  func checkAnswer(url:NSURL, completed: InstagramAuthorizationHandler) {
    let key = "access_token="
    if url.absoluteString.rangeOfString(key) != nil {
      guard let accessToken = url.absoluteString.componentsSeparatedByString(key).reverse().first else {
        return
      }
      self._session.accessToken = accessToken
      completed(result: .Success())
    }
  }
}