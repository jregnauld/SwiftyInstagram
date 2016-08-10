//
//  SessionTests.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/10/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram
import Quick
import Nimble

class SessionTests: QuickSpec {
  
  override func spec() {
    describe("Session tests") {
      it("will init a shared Session with a simple Configuration and Get an authorization URL") {
        let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        let urlToTest = NSURL(string: ConstantsTests.authorizationURL + "?client_id=toto&redirect_uri=http://toto.com/titi&response_type=token")!
        expect(Session.sharedSession().authorizationURL.absoluteString) == urlToTest.absoluteString
      }

    }
  }
}
