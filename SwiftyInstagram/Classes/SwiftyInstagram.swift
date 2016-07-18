//
//  SwiftyInstagram.swift
//  Pods
//
//  Created by Julien Regnauld on 7/18/16.
//
//

import Foundation

public class SwiftyInstagram{
  
  public static let sharedInstance = SwiftyInstagram()
  private init() {}
  private var authConfig: InstagramAuthConfig?
  
  public func application(secretID: String, redirectURL: String) {
     self.authConfig = InstagramAuthConfig(secretID: secretID, redirectURL: redirectURL)
  }
  
  public func getInstagramAuthConfig() throws -> InstagramAuthConfig {
    guard let config = authConfig else {
      throw SwiftyInstagramError.ConfigEmpty
    }
    return config
  }
}