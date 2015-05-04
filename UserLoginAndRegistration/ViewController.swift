//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by Prince Hunter on 03/05/15.
//  Copyright (c) 2015 techwizard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        let isUserLogedIn = NSUserDefaults.standardUserDefaults().stringForKey("isUserLogedIn");
        if(isUserLogedIn == "false")
        {
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }

}

