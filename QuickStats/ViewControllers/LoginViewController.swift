//
//  LoginViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController, Storyboarded {
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(_ sender: UIButton) {
        checkLogin(username: username.text!, password: password.text!) { (_) in
            Settings.shared.set(self.username.text!, forKey: .username)
            Settings.shared.set(self.password.text!, forKey: .password)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
