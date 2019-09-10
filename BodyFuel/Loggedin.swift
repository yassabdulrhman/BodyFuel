//
//  BmiViewController.swift
//  BodyFuel
//
//  Created by Nouf Alsaleh on 26/05/1439 AH.
//  Copyright © 1439 Nouf Alsaleh. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth

class Loggedin: UIViewController {

    @IBAction func loggedTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
             print("loged out")
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        } catch {
            print("there was an issue ")
        }
    }
    @IBAction func dismiss(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
