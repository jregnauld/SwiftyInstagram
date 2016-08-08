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
  public init(clientID: String, redirectURL: String) {
    self.clientID = clientID
    self.redirectURL = redirectURL
  }
}