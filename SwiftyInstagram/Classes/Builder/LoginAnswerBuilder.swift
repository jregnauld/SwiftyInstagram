//
//  LoginAnswerBuilder.swift
//  Pods
//
//  Created by Julien Regnauld on 8/21/16.
//
//

import Foundation

class LoginAnswerBuilder {
  fileprivate let url: URL
  let key = "access_token="
  init(url: URL) {
    self.url = url
  }
  func getAnswer() -> AnyObject? {
    if url.absoluteString.range(of: key) != nil {
      return self.buildSuccessAnswer()
    }
    return buildErrorAnswer()
  }
  fileprivate func buildErrorAnswer() -> AnyObject? {
    guard let errorReason = self.url.getQueryItemValueForKey("error_reason"),
      let errorType = self.url.getQueryItemValueForKey("error"),
      let errorDescription = self.url.getQueryItemValueForKey("error_description") else {
        return nil
    }
    return Error(reason: errorReason, type: errorType, description: errorDescription)
  }
  fileprivate func buildSuccessAnswer() -> AnyObject {
      guard let accessToken = self.url.absoluteString.components(separatedBy: self.key).reversed().first else {
        return Error(reason: "access token not found", type: "unknown", description: "Instagram didn't send an access token.")
      }
      return accessToken as AnyObject
  }
}
