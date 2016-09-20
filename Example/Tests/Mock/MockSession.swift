//
//  MockSession.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/10/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram

private var _twiceSharedSession: TwiceSession?
class TwiceSession: Session {
  var calledTwice: Bool
  override init(configuration: Configuration) {
    self.calledTwice = false
    super.init(configuration: configuration)
  }
  override class func setupSharedSessionWithConfiguration(_ configuration: Configuration) {
    if _twiceSharedSession == nil {
      _twiceSharedSession = TwiceSession(configuration: configuration)
    } else {
      (self.sharedSession() as! TwiceSession).calledTwice = true
    }
  }
  override class func sharedSession()-> Session {
    return _twiceSharedSession!
  }
}

private var _emptySharedSession: EmtpyMockSession?
class EmtpyMockSession: Session {
  var emptySharedSession: Bool
  override init(configuration: Configuration) {
    self.emptySharedSession = false
    super.init(configuration: configuration)
  }
  override class func setupSharedSessionWithConfiguration(_ configuration: Configuration) {
  }
  override class func sharedSession()-> Session {
    guard _emptySharedSession != nil else {
        _emptySharedSession = EmtpyMockSession(configuration: Configuration(client: Client(clientID: "", redirectURL: "")))
        _emptySharedSession!.emptySharedSession = true
      return _emptySharedSession!
    }
    return Session(configuration: Configuration(client: Client(clientID: "", redirectURL: "")))
  }
}
private var _mockSharedSession: Session?

class MockSession: Session {
  override class func setupSharedSessionWithConfiguration(_ configuration: Configuration) {
    _mockSharedSession = Session(configuration: configuration)
  }
  override class func sharedSession()-> Session {
    return _mockSharedSession!
  }
  class func destroy() {
    _twiceSharedSession = nil
  }
}
