//
//  Session.swift
//  Pods
//
//  Created by Julien Regnauld on 8/10/16.
//
//

import Foundation

private var _sharedSession: Session?

open class Session {
  let configuration: Configuration
  var accessToken: String?
  open lazy var authorizationURL: URL = {
    var authorizationURLComponents = URLComponents(string: SwiftyInstagramConstants.authorizationURL)
    var params = [URLQueryItem]()
    for (headerKey, value)  in self.configuration.authorizationParameters().sorted(by: <) {
      params.append(URLQueryItem(name: headerKey, value: value))
    }
    authorizationURLComponents?.queryItems = params
    return authorizationURLComponents!.url!
  }()
  open lazy var redirectURL: String = {
    return self.configuration.client.redirectURL
  }()
  public init(configuration: Configuration) {
    self.configuration = configuration
  }
  open func getAccessToken() -> String? {
    return self.accessToken
  }
  open class func setupSharedSessionWithConfiguration(_ configuration: Configuration) {
    if _sharedSession == nil {
      _sharedSession = Session(configuration: configuration)
    } else {
      fatalError("Do not call twice setupSharedSessionWithConfiguration")
    }
  }
  open class func sharedSession()-> Session {
    guard let sharedSession = _sharedSession else {
      fatalError("please call setupSharedSessionWithConfiguration to setup the session")
    }
    return sharedSession
  }
}
