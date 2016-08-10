//
//  Session.swift
//  Pods
//
//  Created by Julien Regnauld on 8/10/16.
//
//

import Foundation

private var _sharedSession: Session?

public class Session {
  let configuration: Configuration
  public lazy var authorizationURL: NSURL = {
    var authorizationURLComponents = NSURLComponents(string: SwiftyInstagramConstants.authorizationURL)
    var params = [NSURLQueryItem]()
    for (headerKey, value)  in self.configuration.authorizationParameters().sort(<) {
      params.append(NSURLQueryItem(name: headerKey, value: value))
    }
    authorizationURLComponents?.queryItems = params
    return authorizationURLComponents!.URL!
  }()
  public init(configuration: Configuration) {
    self.configuration = configuration
  }
  public class func setupSharedSessionWithConfiguration(configuration: Configuration) {
    if _sharedSession == nil {
      _sharedSession = Session(configuration: configuration)
    } else {
      fatalError("Do not call twice setupSharedSessionWithConfiguration")
    }
  }
  public class func sharedSession()-> Session {
    guard let sharedSession = _sharedSession else {
      fatalError("please call setupSharedSessionWithConfiguration to setup the session")
    }
    return sharedSession
  }
}