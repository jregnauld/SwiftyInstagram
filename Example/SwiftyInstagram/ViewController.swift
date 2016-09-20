//
//  ViewController.swift
//  SwiftyInstagram
//
//  Created by Julien on 06/25/2016.
//  Copyright (c) 2016 Julien. All rights reserved.
//

import UIKit
import SwiftyInstagram
class ViewController: UIViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let loginManager = LoginManager()
    loginManager.loginFromViewController(self) { (result) in
      print(result)

      switch result {
      case .success():
        break
      case .failure(let error):
        print(error.reason)
        break
      }
    }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

