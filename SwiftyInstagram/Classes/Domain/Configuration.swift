//
//  Configuration.swift
//  Pods
//
//  Created by Julien Regnauld on 8/8/16.
//
//

import Foundation

public struct Configuration {
  let client: Client
  let parameters: [Scope]?
  public init(client: Client){
    self.init(client: client, parameters: nil)
  }
  public init(client: Client, parameters: [Scope]?) {
    self.client = client
    self.parameters = parameters
  }
  public func authorizationParameters() -> [String: String] {
    guard let parameters = self.parameters where self.parameters?.count > 0 else {
      return ["client_id": self.client.clientID,
              "redirect_uri": self.client.redirectURL,
              "response_type": "token"]
    }
    var scopeValues: String = ""
    parameters.enumerate().map({ (index, element) in
            if index == 0 {
              scopeValues +=  element.rawValue
            } else {
              scopeValues +=  "+" + element.rawValue
            }
    })
    return ["client_id": self.client.clientID,
            "redirect_uri": self.client.redirectURL,
            "response_type": "token",
            "scope": scopeValues]
  }
}