//
//  InstagramAuthConfig.swift
//  Pods
//
//  Created by Julien Regnauld on 7/18/16.
//
//

import Foundation

public class InstagramAuthConfig {
  public let secretID: String
  public let redirectURL: String
  init(secretID: String, redirectURL: String) {
    self.secretID = secretID
    self.redirectURL = redirectURL
  }
}