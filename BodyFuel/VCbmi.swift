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
// مكتبات التعامل مع الفايربيس

class VCbmi: UIViewController {


    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var HeightTextField: UILabel!
    @IBOutlet weak var WeightTextField: UILabel!
    @IBOutlet weak var BMITextField: UILabel!
    @IBOutlet weak var health: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // ref
        // لتحديد مكان قاعدة البيانات، ضروري ايستخدامة في سبيل القرائة والكتابة من وعلى قاعدة البيانات
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            // للإستعلام من قاعدة البيانات
            let userID = Auth.auth().currentUser?.uid
            //Auth.auth().currentUser
            // المستخدم الحالي
            // uid = User ID
             // لسحب آي دي المستخدم الحالي واسنادة للمتغير UserUD
            ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                //للاستعلام من المصفوفة Users الموجودة في قاعدة البيانات
                // حيث اني ابحث عن المصفوفة الفرعية التي تحمل الاسم المطابق للـ آي دي المستخدم الحالي
                
                
                let value = snapshot.value as? NSDictionary
                //سيتم حفظ القيم المستعلم عنها داخل المتغير السابق على شكل مصفوفة
                let username = value?["Name"] as? String ?? ""
            // من داخل المصفوفة هناك قيمة داخل وعاء يحمل العنوان Name وفي حالة ان الوعاء فارغ سيتم اسناد قيمة فارغة ""
                let Height = value!["Height"] as? Int ?? 0
                let weight = value!["weight"] as? Int ?? 0
               
                
                self.nameTextField.text=username
                //قمنا بطباعة الاسم الذي تم الاستعلام عنه داخل الحقل nameTextField
                self.HeightTextField.text=String(Height)
                self.WeightTextField.text=String(weight)

            }) { (error) in
                print(error.localizedDescription)
                // في حالة التعثر في تنفيذ الامر السابق، سيتم طباعة الخطأ في الكونسل
            }
        // Do any additional setup after loading the view.
    })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func StartBMI(_ sender: Any) {
        // فنكشن عند الضغط على زر Start
        let Height = Double(HeightTextField.text!)!*0.01
        //Double(HeightTextField.text!)
        // لتحويل القيمة المدخلة من نص إلى عدد عشري حتى يتسنى لنا التعامل معها
        //*0.01
        //لتحويل القيمة، على سبيل المثال من ١٥٠  إلى ١.٥ لتحقيق متطلبات معادلة الـ BMI
        let weight = Double(WeightTextField.text!)!*1
        // نفس القيمة هنا لن نقوم بتغيرها،
        // رواببي الله يسعدك انا سويت حركة غبية هنا ضربت القيمة في واحد، راح ترجع لي نفس القيمة يعني ما كان له داعي اضرب من الاساس
        
        let IntBMI: Double = Double(weight / (Height * Height))
        // معادلة الBMI
        // الوزن تقسيم الطول آوس اثنين
        BMITextField.text=String(Double(round(100*IntBMI)/100))
        // هنا لإزالة االاعداد العشرية، على سبيل المثال
        //16.2222222
        // بعد العملية السباقة سيكون العدد 16.22
        
        
        
        
        if(Double(round(100*IntBMI)/100)>25.0)
        {
            health.text="وزن زائد!!"
            health.textColor=UIColor.red
        }
        else  if(Double(round(100*IntBMI)/100)>15.0)
        {
            health.text="جميل، أستمر على هذا الوزن"
            health.textColor=UIColor.green
        }
        else
        {
            health.text="وزنك ضعيف جداً!!"
            health.textColor=UIColor.yellow
        }
        health.isHidden=false
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //فنكشن لتراجع للانترفيس السابق
    }

}
