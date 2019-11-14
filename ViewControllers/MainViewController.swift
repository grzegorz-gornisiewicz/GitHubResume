//
//  ViewController.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 05/02/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onEditingChanged(_ sender: Any) {
        if let accountname = (sender as? UITextField)?.text {
            UserDefaults.standard.set(accountname, forKey: "AccountName")
        }
    }
}

