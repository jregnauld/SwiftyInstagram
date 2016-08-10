//
//  MockSession.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/10/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram

private var _mockSharedSession: MockSession?

class MockSession: Session {
  var calledTwice: Bool
  override init(configuration: Configuration) {
    self.calledTwice = false
    super.init(configuration: configuration)
  }
  override class func setupSharedSessionWithConfiguration(configuration: Configuration) {
    if _mockSharedSession == nil {
      _mockSharedSession = MockSession(configuration: configuration)
    } else {
      (self.sharedSession() as! MockSession).calledTwice = true
    }
  }
  override class func sharedSession()-> Session {
    return _mockSharedSession!
  }
}