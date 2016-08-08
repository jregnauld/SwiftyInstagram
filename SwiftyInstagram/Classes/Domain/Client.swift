//
//  Client.swift
//  Pods
//
//  Created by Julien Regnauld on 8/8/16.
//
//

import Foundation

public struct Client {
  let clientID: String
  let redirectURL: String
  public var authorizationURL: NSURL {
    mutating get {
      return NSURL(string: SwiftyInstagramConstants.authorizationURL + "?client_id=" + self.clientID + "&redirect_uri=" + self.redirectURL + "&response_type=token")!
    }
  }
  public init(clientID: String, redirectURL: String) {
    self.clientID = clientID
    self.redirectURL = redirectURL
  }
}