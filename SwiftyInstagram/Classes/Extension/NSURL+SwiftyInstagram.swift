//
//  NSURL+SwiftyInstagram.swift
//  Pods
//
//  Created by Julien Regnauld on 8/21/16.
//
//

import Foundation

extension URL {
  func getQueryItemValueForKey(_ key: String) -> String? {
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      return nil
    }
    
    guard let queryItems = components.queryItems else { return nil }
    return queryItems.filter {
      $0.name == key
      }.first?.value
  }
}
