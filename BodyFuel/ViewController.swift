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



class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    let alert = UIAlertController(title: "خطأ", message: "حاول مجدداً", preferredStyle: UIAlertControllerStyle.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Loged in")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCHome") as! ViewController
                self.present(vc, animated: true,completion: nil)
            })
        }
    }
    
    
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.present(vc, animated: true,completion: nil)
        
    }
    
    
    @IBAction func resetPassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPassword") as! ResetPassword
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func vcBMI(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCbmi") as! VCbmi
        self.present(vc, animated: true,completion: nil)
        
    }
    @IBAction func UpdateProfileVC(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
        self.present(vc, animated: true,completion: nil)
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Loggedin") as! Loggedin
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func workingout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutBoard") as! exerciseViewController
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func water(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "waterViewController") as! waterViewController
        self.present(vc, animated: true,completion: nil)
    }
    @IBAction func RunningView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepsVC") as! StepsVC
        self.present(vc, animated: true,completion: nil)
    }
    
    
    
    
}
