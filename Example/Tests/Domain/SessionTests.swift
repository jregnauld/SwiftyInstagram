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
      it("make sure that setupSharedSessionWithConfiguration can not be called twice") {
        let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
        let configuration = Configuration(client: client)
        TwiceSession.setupSharedSessionWithConfiguration(configuration)
        let client2 = Client(clientID: "efwew", redirectURL: "http://fweffwe.fr")
        let configuration2 = Configuration(client: client2)
        TwiceSession.setupSharedSessionWithConfiguration(configuration2)
        expect((TwiceSession.sharedSession() as! TwiceSession).calledTwice).to(beTrue())
      }
      it("make sure that we can't call sharedSession before setupSharedSessionWithConfiguration") {
        expect((EmtpyMockSession.sharedSession() as! EmtpyMockSession).emptySharedSession).to(beTrue())
      }
      it("will init a session with a configuration with many scopes and get an authorization URL") {
        let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
        let configuration = Configuration(client: client, parameters: [Scope.comments, Scope.followerList])
        let session = Session(configuration: configuration)
        let urlToTest = NSURL(string: ConstantsTests.authorizationURL + "?client_id=toto&redirect_uri=http://toto.com/titi&response_type=token&scope=comments+follower_list")!
        expect(session.authorizationURL.absoluteString) == urlToTest.absoluteString
      }
      it("will init a sesession with a configuration with one scope and get an authorization URL") {
        let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
        let configuration = Configuration(client: client, parameters: [Scope.comments])
        let session = Session(configuration: configuration)
        let urlToTest = NSURL(string: ConstantsTests.authorizationURL + "?client_id=toto&redirect_uri=http://toto.com/titi&response_type=token&scope=comments")!
        expect(session.authorizationURL.absoluteString) == urlToTest.absoluteString
        print(session.authorizationURL.absoluteString)
      }
      it("will init a sesession with a configuration with an array of scopes empty and get an authorization URL") {
        let client = Client(clientID: "toto", redirectURL: "http://toto.com/titi")
        let configuration = Configuration(client: client, parameters: [Scope]())
        let session = Session(configuration: configuration)
        let urlToTest = NSURL(string: ConstantsTests.authorizationURL + "?client_id=toto&redirect_uri=http://toto.com/titi&response_type=token")!
        expect(session.authorizationURL.absoluteString) == urlToTest.absoluteString
        print(session.authorizationURL.absoluteString)
      }
    }
  }
}
