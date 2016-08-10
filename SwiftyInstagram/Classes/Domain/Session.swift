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
  private init(configuration: Configuration) {
    self.configuration = configuration
  }
  public class func setupSharedSessionWithConfiguration(configuration: Configuration) {
    _sharedSession = Session(configuration: configuration)
  }
  public class func sharedSession()-> Session {
    return _sharedSession!
  }
}