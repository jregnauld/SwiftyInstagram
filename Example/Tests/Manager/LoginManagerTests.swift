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
    beforeEach {
      let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
      let configuration = Configuration(client: client)
      MockSession.setupSharedSessionWithConfiguration(configuration)
    }
    afterEach{
      MockSession.destroy()
    }
    describe("it will test Login manager") {
      it(" will log in to Instagram with success") {
        let authorizationViewController = MockAuthorizationViewController(authorizationURL: MockSession.sharedSession().authorizationURL, redirectURL:  MockSession.sharedSession().redirectURL)
        let loginManager = LoginManager(session: MockSession.sharedSession(), authorizationViewController: authorizationViewController)
        var isSuccess = false
          loginManager.loginFromViewController(UIViewController(), completed: { (result) in
            switch result {
            case .Success():
              isSuccess = true
            case .Failure():
              fail()
            }
          })
        authorizationViewController.successAnswer()
        expect(isSuccess) == true
        expect(MockSession.sharedSession().getAccessToken()) != nil
      }
    }
  }
}
