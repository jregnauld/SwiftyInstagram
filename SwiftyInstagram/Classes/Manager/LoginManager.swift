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
  }
  public func loginFromViewController(viewController: UIViewController, completed: InstagramAuthorizationHandler) {
    self._authorizationViewController.delegate = self
    self._authorizationHandler = completed
    let navigationController = UINavigationController(rootViewController: self._authorizationViewController)
    viewController.presentViewController(navigationController, animated: true, completion: nil)
  }
  func getWebViewAnswer(url: NSURL) {
    //if url != authorization && access token dans url
    // error nsurlcomponent a error_reason, error, error_descption
//    self._authorizationHandler!(result: .Success())
  }
}