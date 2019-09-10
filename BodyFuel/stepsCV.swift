//
//  StepsVC.swift
//  Body Fuel
//
//  Created by Budyfuel 2/17/18.
//  Copyright © 2018 PNU. All rights reserved.
//

import UIKit
import HealthKit
// استدعاء لمكتبة برنامج الصحة المدمج مع النظام


class StepsVC: UIViewController {
    let healthStore = HKHealthStore()
    // انشاء متغير لتعامل مع برنامج الصحة
    
    @IBAction func authoriseHealthKitAccess(_ sender: Any) {
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
            // تحديد ما نرغب بالتعامل معه، والتي هي الخطوات
        ]
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (_, _) in
            print("authrised???")
        }
        // طلب الاذن بقراءه البيانات من برنامج الصحة
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
            if let e = error {
                print("oops something went wrong during authorisation \(e.localizedDescription)")
            } else {
                print("User has completed the authorization flow")
            }}}
    // ايضاً نفس الامر السابق نطلب الاذن بقراءة البيانات
   
    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        // لتحديدالخطوات
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now-2)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        // لتحديد المدة الزمنية
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(resultCount)
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            DispatchQueue.main.async {
                completion(resultCount)
            }}
        // كل ما هو مذكور اعلاه خاص بالاستعلام عن الخطوات
        healthStore.execute(query)
        // لتنفيذ العملية المذكورة اعلاه
    }
    
    @IBOutlet weak var totalSteps: UILabel!
    // لتعريف الحلق الموجود على الشاشة

    
    @IBAction func getTotalSteps(_ sender: Any) {
        // فنكشن عند الضغط على الزر
        getTodaysSteps { (result) in
            // استعداء للفنكشن اعلاه
            print("\(result)")
            DispatchQueue.main.async {
                self.totalSteps.text = "\(result)"
                // طباعة القيمة في الحقل على الشاشة
            }
        }
    }
    
    //الكود التالي الخاص بعرض الشاشة
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func exitVC(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
}


