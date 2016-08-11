//
//  LoginManager.swift
//  Pods
//
//  Created by Julien Regnauld on 8/11/16.
//
//

import Foundation

public class LoginManager {
  private let session  = Session.sharedSession()
  public init() {
    
  }
  public func loginFromViewController(viewController: UIViewController) {
    let authorizationViewController = AuthorizationViewController(authorizationURL: session.authorizationURL)
    let navigationController = UINavigationController(rootViewController: authorizationViewController)
    viewController.presentViewController(navigationController, animated: true, completion: nil)
  }
}