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

private var _emptySharedSession: EmtpyMockSession?

class EmtpyMockSession: Session {
  var emptySharedSession: Bool
  override init(configuration: Configuration) {
    self.emptySharedSession = false
    super.init(configuration: configuration)
  }
  override class func setupSharedSessionWithConfiguration(configuration: Configuration) {
  }
  override class func sharedSession()-> Session {
    guard let emptySharedSession = _emptySharedSession else {
        _emptySharedSession = EmtpyMockSession(configuration: Configuration(client: Client(clientID: "", redirectURL: "")))
        _emptySharedSession!.emptySharedSession = true
      return _emptySharedSession!
    }
    return Session(configuration: Configuration(client: Client(clientID: "", redirectURL: "")))
  }
}