//
//  LoginViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import os.log

class LoginViewController: UITableViewController, Storyboarded {
    private let logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "WidgetListViewController")

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var serverField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        loginButton.isEnabled = [
            username.text,
            password.text,
            serverField.text
            ].allSatisfy { $0 != "" }
    }
    
    @IBAction func login(_ sender: UIButton) {
        checkLogin(username: username.text!, password: password.text!) { (_) in
            os_log("Successfully logged in as %s", log: self.logger, type: .default, self.username.text!)

            DispatchQueue.main.async {
                Settings.shared.set(self.username.text!, forKey: .username)
                Settings.shared.set(self.serverField.text!, forKey: .server)
                Settings.keychain.set(self.password.text!, forKey: .server)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
