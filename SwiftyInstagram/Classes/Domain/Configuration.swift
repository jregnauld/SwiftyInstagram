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
  let parameters: [Scope]
  public init(client: Client){
    self.init(client: client, parameters: nil)
  }
  public init(client: Client, parameters: [Scope]?) {
    self.client = client
    if let parameters = parameters {
      self.parameters = parameters
    } else {
      self.parameters = [Scope]()
    }
  }
  public func authorizationParameters() -> [String: String] {
    return ["client_id": self.client.clientID,
            "redirect_uri": self.client.redirectURL,
            "response_type": "token"]
  }
}