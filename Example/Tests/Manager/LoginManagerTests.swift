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
    describe("Login manager Tests") {
      it("will log in to Instagram with success") {
        let authorizationViewController = MockAuthorizationViewController(authorizationURL: MockSession.sharedSession().authorizationURL, redirectURL:  MockSession.sharedSession().redirectURL)
        let loginManager = LoginManager(session: MockSession.sharedSession(), authorizationViewController: authorizationViewController)
        var isSuccess = false
          loginManager.loginFromViewController(UIViewController(), completed: { (result) in
            switch result {
            case .Success():
              isSuccess = true
            case .Failure(_):
              fail()
            }
          })
        authorizationViewController.successAnswer()
        expect(isSuccess) == true
        expect(MockSession.sharedSession().getAccessToken()) != nil
      }
      it("will fail to log in") {
        let authorizationViewController = MockAuthorizationViewController(authorizationURL: MockSession.sharedSession().authorizationURL, redirectURL:  MockSession.sharedSession().redirectURL)
        let loginManager = LoginManager(session: MockSession.sharedSession(), authorizationViewController: authorizationViewController)
        var isFailure = false
        loginManager.loginFromViewController(UIViewController(), completed: { (result) in
          switch result {
          case .Success():
            fail()
          case .Failure(let error):
            expect(error.type) == "access_denied"
            expect(error.reason) == "user_denied"
            expect(error.description) == "The+user+denied+your+request."
            isFailure = true
          }
        })
        authorizationViewController.failureAnswer()
        expect(isFailure) == true
        expect(MockSession.sharedSession().getAccessToken()).to(beNil())
      }
      it("will ignore webview answer when it's the same that the authorization url") {
        let authorizationViewController = MockAuthorizationViewController(authorizationURL: MockSession.sharedSession().authorizationURL, redirectURL:  MockSession.sharedSession().redirectURL)
        let loginManager = LoginManager(session: MockSession.sharedSession(), authorizationViewController: authorizationViewController)
        var hasCheckURL = false
        loginManager.loginFromViewController(UIViewController(), completed: { (result) in
          hasCheckURL = true
          switch result {
          case .Success():
            fail()
          case .Failure(_):
            fail()
          }
        })
        authorizationViewController.authorizationURLAnswer()
        expect(hasCheckURL) == false
        expect(MockSession.sharedSession().getAccessToken()).to(beNil())

      }
    }
  }
}
