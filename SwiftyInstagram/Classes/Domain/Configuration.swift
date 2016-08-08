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
}