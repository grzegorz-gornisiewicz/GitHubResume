//
//  ViewController.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 05/02/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onEditingChanged(_ sender: Any) {
        if let accountname = (sender as? UITextField)?.text {
            UserDefaults.standard.set(accountname, forKey: "AccountName")
        }
    }
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        performSegue(withIdentifier: "ShowResume", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

