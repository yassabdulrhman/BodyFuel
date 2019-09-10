//
//  BmiViewController.swift
//  BodyFuel
//
//  Created by Nouf Alsaleh on 26/05/1439 AH.
//  Copyright © 1439 Nouf Alsaleh. All rights reserved.
//


import UIKit
import FirebaseAuth

class ResetPassword: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    // حقل البريد الألكتروني
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        //فنكشن إعادة تعيين الباسورد
        let email = emailTextField.text
        // email
        // متغير ليحتوي على القيمة المدخل في حقل الايميل
        Auth.auth().sendPasswordReset(withEmail: email!, completion: {(error) in
            // فايربيس توفر امكانية استعادة الباسورد باستخدام السطر اعلاه
            // يأخذ الامر اعلاه على قيمة واحدة فقط وهي الايميل
            if error == nil{
                // create the alert
                let alert = UIAlertController(title: "تم الأرسال", message: "ستصلك رسالة إعادة تعيين كلمة المرور على البريد الألكتروني", preferredStyle: UIAlertControllerStyle.alert)
                // في حالة نجاح العملية،
// سيتم انشاء متغير باسم alert
                // سيظهر مربع رسالة على الشاشة لتنويه بذالك
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "إغلاق", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                }))
                // بالاضافة لزر اغلاق لمربع الرسالة
                // عند الضغط على الزر سيتم إصراف الواجهه >> بمعنى سيعود للواجهة الرئيسية
                
                

                self.present(alert, animated: true, completion: nil)
                                // لعرض الرسالة السابقة
                
            }
            else
            {
                print(error!.localizedDescription)
                // سيتم طباعة الخطأ في حالة تواجدة
            }
        })
    }
    

}
