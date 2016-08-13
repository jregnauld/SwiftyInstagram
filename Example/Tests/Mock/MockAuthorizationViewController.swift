//
//  MockAuthorizationViewController.swift
//  SwiftyInstagram
//
//  Created by Julien Regnauld on 8/13/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyInstagram

class MockAuthorizationViewController : AuthorizationViewController {
  let successURL: NSURL
  let failureURL: NSURL
  let withSuccess: Bool
  init(authorizationURL: NSURL, redirectURL: String, withSuccess: Bool) {
    self.withSuccess = withSuccess
    self.successURL = NSURL(string: redirectURL + "/#access_token=357230059.d19d478.0b0ec3f4ecb0450fa9c7d41821ec68a9")!
    print(self.successURL)
    self.failureURL = NSURL(string: redirectURL + "/?error_reason=user_denied&error=access_denied&error_description=The+user+denied+your+request.")!
     print(self.failureURL)
    super.init(authorizationURL: authorizationURL)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
  }
  override func viewDidAppear(animated: Bool) {
  }
}