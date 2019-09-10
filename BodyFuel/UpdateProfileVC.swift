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
import FirebaseDatabase

class UpdateProfileVC: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var WeightTextField: UITextField!
    @IBOutlet weak var HeightTextField: UITextField!
    @IBOutlet weak var SegmentedControlWeight: UISegmentedControl!
    @IBOutlet weak var SegmentedControlHeight: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let userID = Auth.auth().currentUser?.uid
            ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let username = value?["Name"] as? String ?? ""
                let Height = value!["Height"] as? Int ?? 0
                let weight = value!["weight"] as? Int ?? 0
                
                self.nameTextField.text=username
                 self.HeightTextField.text=String(Height)
                 self.WeightTextField.text=String(weight)
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
        
    })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        var weight = 0.0
        if(SegmentedControlWeight.selectedSegmentIndex==0)
        {
            weight = Double(WeightTextField.text!)!
        }
        else
        {
            weight = Double(WeightTextField.text!)!*(0.45359237)
        }
        
        var Height=0.0
        if(SegmentedControlHeight.selectedSegmentIndex==1)
        {
            Height = Double(HeightTextField.text!)!
        }
        else
        {
            Height = Double(HeightTextField.text!)!*(30.48)
        }
        print(weight)
        let userID = Auth.auth().currentUser?.uid
        let userName =  self.nameTextField.text
        let post = [
            "Name": userName ?? "noname",
            "weight": weight,
            "Height":   Height
            ] as [String : Any]
        Database.database().reference().child("Users").child(userID!).setValue(post)
        return
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == WeightTextField || textField == HeightTextField){
            scrollview.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}


