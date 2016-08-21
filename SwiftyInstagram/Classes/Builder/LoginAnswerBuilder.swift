//
//  LoginAnswerBuilder.swift
//  Pods
//
//  Created by Julien Regnauld on 8/21/16.
//
//

import Foundation

class LoginAnswerBuilder {
  private let url: NSURL
  let key = "access_token="
  init(url: NSURL) {
    self.url = url
  }
  func getAnswer() -> AnyObject? {
    if url.absoluteString.rangeOfString(key) != nil {
      return self.buildSuccessAnswer()
    }
    return buildErrorAnswer()
  }
  private func buildErrorAnswer() -> AnyObject? {
    guard let errorReason = self.url.getQueryItemValueForKey("error_reason"),
      let errorType = self.url.getQueryItemValueForKey("error"),
      let errorDescription = self.url.getQueryItemValueForKey("error_description") else {
        return nil
    }
    return Error(reason: errorReason, type: errorType, description: errorDescription)
  }
  private func buildSuccessAnswer() -> AnyObject {
      guard let accessToken = self.url.absoluteString.componentsSeparatedByString(self.key).reverse().first else {
        return Error(reason: "access token not found", type: "unknown", description: "Instagram didn't send an access token.")
      }
      return accessToken
  }
}