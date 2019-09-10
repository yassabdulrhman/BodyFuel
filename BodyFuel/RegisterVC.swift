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
// تعريف المكتبات الي تسمح لنا بتعامل مع صلاحيات الدخول المقدمة من فاير بيس
// وايضا قاعدة الباينات

class RegisterVC: UIViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var WeightTextField: UITextField!
    @IBOutlet weak var HeightTextField: UITextField!
    @IBOutlet weak var SegmentedControlWeight: UISegmentedControl!
    @IBOutlet weak var SegmentedControlHeight: UISegmentedControl!
    @IBOutlet weak var birthtextFiled: UITextField!
    
    let picker = UIDatePicker() // for birthDate
    // تعريف الحقول الموجودة على الشاشة
    
    @IBAction func IndexChanged(_ sender: Any) {
        WeightTextField.isEnabled=true
    }
    // فنشن لتفعيل مربع ادخال الوزن عن الضغط على نوع الوزن
    @IBAction func IndexChanged2(_ sender: Any) {
        HeightTextField.isEnabled=true
    }
    // مشابة لما أعلا
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBAction func createAccountTapped(_ sender: Any) {
        guard let username = nameTextField.text, nameTextField.text?.characters.count != 0
            else {
                nameTextField.layer.borderWidth = 3.0;
                nameTextField.layer.borderColor = UIColor.red.cgColor
                nameTextField.layer.cornerRadius=8
                return
        }
        guard let email = emailTextField.text, emailTextField.text?.characters.count != 0
        // valid email
            else {
                emailTextField.layer.borderWidth = 3.0;
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.cornerRadius = 8
                return
        }
        if isvalidEmail(emailID:email) == false {
            emailTextField.layer.borderWidth = 3.0;
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.cornerRadius = 8
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text?.characters.count != 0
            else {
                passwordTextField.layer.borderWidth = 3.0;
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.cornerRadius = 8
                return
        }
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.color = UIColor.black
        activityIndicator.backgroundColor = UIColor(white: 1, alpha: 0.5)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        view.addSubview(self.activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        var weight = 0.0
        // قمت بتعريف متغير الوزن واعطائه القيمة صفر
        if(SegmentedControlWeight.selectedSegmentIndex==0)
            // شرط آذا المستخدم اختار الكيلو جرام
        {
            weight = Double(WeightTextField.text!)!
            // اذا قثط اسند القيمة مباشرة
        }
        else
        {
            weight = Double(WeightTextField.text!)!*(0.45359237)
            // اذا كانت بالباوند، اذا قم بتحويل القيمة للجرام بعد ذلك احفظ النتيجة
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
        // نفس عملية الوزن هنا لطول
        
        print(weight)
        // لطباعة الوزن في الموسل ليسا الا
        // بالاصح لمتابعة تنفيذ البرنامج
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            //نتاكد ان الايميل والباسورد كلها مليانة
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                // انشأنا حسابباستخدام الايميل
                
                print("Register email and password success")
                //طباعة أخرى في الكونسل
                let userID = Auth.auth().currentUser?.uid
                // هنا قمنا بتعريف متغير سيحتوي على عنوان المستخدم
                let userName =  self.nameTextField.text
                 let birthOFdate = self.birthtextFiled.text
                // هنا متغير سيحتوي على قيمة الحقل الخاص بالأسم
                let post = [
                    // تعريف مصفوفة ستحتوي على القيم السابقة
                    "Name": userName ?? "noname",
                    "weight": weight,
                    "Height":   Height,
                    "email":  email,
                    "DateofBirth":  birthOFdate ?? "noDateofBirth",
                    ] as [String : Any]
                Database.database().reference().child("Users").child(userID!).setValue(post)
                // سيتم ارسال القيم السابقة للصف المسمى Users في قاعدة البيانات
                // بعد ذلك سيتم انشاء جذع جديد تحت مسمى عنوان المستخدم
                // بعد عنوان اسم المستخدم نضع داخله البيانات السابقة
                return
                // [END]
            
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                       print("Loged in")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
               UIApplication.shared.endIgnoringInteractionEvents()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCHome") as! ViewController
                self.present(vc, animated: true,completion: nil)
            }
            
            // لاغلاق الشاشة
        }
        
    }
    //var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // الكود التالي هو لرفع الشاشة للأعلا عندالكتابة في الحقل
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == WeightTextField || textField == HeightTextField){
            scrollview.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    // كود تنزيل الشاشة في حالة الانتهاء من ادخال البيانات
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    // عند الضغط على return في الكيبورد
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func isvalidEmail(emailID:String) -> Bool {
        let emailRegEx = "(^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$)"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: emailID)
    }
    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        birthtextFiled.inputAccessoryView = toolbar
        birthtextFiled.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .date
    }
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        birthtextFiled.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
}
// الكود التالي هو لإخفاء الكيبورد عند الضغط على اي سطح خارج الحقل
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



