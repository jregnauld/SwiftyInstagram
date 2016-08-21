//
//  NSURL+SwiftyInstagram.swift
//  Pods
//
//  Created by Julien Regnauld on 8/21/16.
//
//

import Foundation

extension NSURL {
  func getQueryItemValueForKey(key: String) -> String? {
    guard let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false) else {
      return nil
    }
    
    guard let queryItems = components.queryItems else { return nil }
    return queryItems.filter {
      $0.name == key
      }.first?.value
  }
}