//
//  LoginManagerTests.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram
import Quick
import Nimble

class LoginManagerTests: QuickSpec {
  override func spec() {
    describe("it will test Login manager") {
      let loginManager = LoginManager()
      loginManager.loginFromViewController(UIViewController())
    }
  }
}