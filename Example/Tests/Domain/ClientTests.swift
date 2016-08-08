//
//  ClientTests.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram
import Quick
import Nimble

class ClientTests: QuickSpec {
  override func spec() {
    describe("Client Tests") {
      it(" set a Instagram client with an clientID and a redirect URL") {
        var client = Client(clientID: ConstantsTests.clientID, redirectURL: ConstantsTests.redirectURL)
        let authorizationURL = NSURL(string: ConstantsTests.authorizationURL + "?client_id=" + ConstantsTests.clientID + "&redirect_uri=" + ConstantsTests.redirectURL + "&response_type=token")!
        expect(client.authorizationURL.absoluteString) == authorizationURL.absoluteString
      }
    }
  }
}