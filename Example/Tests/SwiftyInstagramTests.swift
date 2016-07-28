//
//  SwiftyInstagramTests.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 7/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftyInstagram

class SwiftyInstagramTests: QuickSpec {
//   let instagram = SwiftyInstagram.sharedInstance
  override func spec() {
    describe("SwitfyInstagram Tests") {
      it("set the client ID and the redirect URL") {
   
        SwiftyInstagram.sharedInstance.application(ConstantsTests.secretID, redirectURL:ConstantsTests.redirectURL)
        do {
          let secretID = try SwiftyInstagram.sharedInstance.getInstagramAuthConfig().secretID
          expect(secretID) == ConstantsTests.secretID
          let redirectURL = try SwiftyInstagram.sharedInstance.getInstagramAuthConfig().redirectURL
          expect(redirectURL) == ConstantsTests.redirectURL
        } catch {
          fail()
        }
      }
      it("not set the client ID and the redirect URL") {
//        expect(try! SwiftyInstagram.sharedInstance.getInstagramAuthConfig()).to(throwError(SwiftyInstagramError.ConfigEmpty))
      }
    }
  }
}
