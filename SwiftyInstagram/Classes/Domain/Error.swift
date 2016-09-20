//
//  Error.swift
//  Pods
//
//  Created by Julien Regnauld on 8/21/16.
//
//

import Foundation

public protocol ErrorType {
  var reason: String { get }
  var type: String { get }
  var description: String { get }
}

open class Error: ErrorType {
  open let reason: String
  open let type: String
  open let description: String
  init(reason: String, type: String, description: String) {
    self.reason = reason
    self.type = type
    self.description = description
  }
}
