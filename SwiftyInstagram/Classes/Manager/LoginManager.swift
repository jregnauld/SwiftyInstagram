//
//  LoginManager.swift
//  Pods
//
//  Created by Julien Regnauld on 8/11/16.
//
//

import Foundation
public typealias InstagramAuthorizationHandler = ((_ result: AuthorizationResult) -> Void)
public enum AuthorizationResult {
  case success()
  case failure(error: Error)
}
open class LoginManager: AuthorizationDelegate {
  fileprivate let _session: Session
  fileprivate let _authorizationViewController: AuthorizationViewController
  fileprivate var _authorizationHandler: InstagramAuthorizationHandler?
  public init(session: Session = Session.sharedSession(), authorizationViewController: AuthorizationViewController? = nil) {
    self._session = session
    if let authorizationViewController = authorizationViewController {
      self._authorizationViewController = authorizationViewController
    } else {
      self._authorizationViewController = AuthorizationViewController(authorizationURL: self._session.authorizationURL)
    }
    self._authorizationViewController.delegate = self
  }
  open func loginFromViewController(_ viewController: UIViewController, completed: @escaping InstagramAuthorizationHandler) {
    self._authorizationHandler = completed
    let navigationController = UINavigationController(rootViewController: self._authorizationViewController)
    viewController.present(navigationController, animated: true, completion: nil)
  }
  open func getWebViewAnswer(_ url: URL) {
    self.checkAnswer(url) { (result) in
      self._authorizationHandler!(result)
    }
  }
  func checkAnswer(_ url:URL, completed: InstagramAuthorizationHandler) {
    let builder = LoginAnswerBuilder(url: url)
    switch builder.getAnswer() {
      case is String:
        self._session.accessToken = builder.getAnswer() as! String
        completed(.success())
      case is Error:
        completed(.failure(error: builder.getAnswer() as! Error))
    default: break
    }
  }
   
}
