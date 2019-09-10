//
//  BmiViewController.swift
//  BodyFuel
//
//  Created by Nouf Alsaleh on 26/05/1439 AH.
//  Copyright © 1439 Nouf Alsaleh. All rights reserved.
//


import UIKit
import SQLite
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Lottie

class waterViewController: UIViewController {
    
    private var downloadTask: URLSessionDownloadTask?
    private var boatAnimation: LOTAnimationView?
    var positionInterpolator: LOTPointInterpolatorCallback?
    
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var NeededCups: UILabel!
    @IBOutlet weak var waterProgress: UILabel!
    @IBOutlet weak var animationView: UIView!
    
    var weightLet=55
    var neededGlasses=0.0
    var glassNum=0.0
    var cupSize = 0.0;
    var usersID=""
    
    var database: Connection!
    
    let waterTable = Table("Water")
    let idColumn = Expression<Int>("id")
    let userIDColumn = Expression<String>("uID")
    let ozColumn = Expression<Double>("oz")
    let weightColumn = Expression<Int>("weight")
   let date_timeColumn = Expression<Date>("date_time")

    override func viewDidLoad() {
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
                let value = snapshot.value as? NSDictionary
                //سيتم حفظ القيم المستعلم عنها داخل المتغير السابق على شكل مصفوفة
                let weight2 = value!["weight"] as? Int ?? 0
                self.weightLet=weight2
                self.usersID=userID!
                print("userID:",self.usersID)
                print("weightLet:",self.weightLet)
                self.weight.text=String(self.weightLet)
                
                //1- weight * 2.20 to convert into (lbs)
                //2- ( / 2) to get our oz
                //3- [8.45] is the size of one full glass
                //4- ( / 8.45) to get our need of glasses per a day
                self.neededGlasses = (((Double(self.weightLet)*2.20)/2)/8.45)
                print("neededGlasses: ",self.neededGlasses)
                print("Int(neededGlasses): ",Int(self.neededGlasses))
                self.NeededCups.text=String(Int(self.neededGlasses))
                self.waterProgress?.text="0%"
                
                
                super.viewDidLoad()
                do{
                    let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileUrl = documentDirectory.appendingPathComponent("water").appendingPathExtension("sqlite3")
                    let database = try Connection(fileUrl.path)
                    self.database = database
                    
                }
                catch
                {
                    print(error)
                }
                
                let gregorian = Calendar(identifier: .gregorian)
                let today = Date()
                //let tomorrow2 = Calendar.current.date(byAdding: .day, value: -1, to: now)
                var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: today)
                // Change the time to 00:00:00 in your locale
                components.hour = 0;components.minute = 0;components.second = 0
                //TimeZone
                components.timeZone = TimeZone(secondsFromGMT: 0)
                //Start of the day
                let startDay = gregorian.date(from: components)!
                
                print(startDay)
                
                // To drop the table:
                /*do
                {
                    try self.database.run(self.waterTable.drop())
                }
                catch
                {
                    print(error)
                }
 */
                self.createTable()
                do{
                    let count = try self.database.scalar(self.waterTable.filter(self.date_timeColumn >= startDay).count)
                    self.glassNum=Double(count)
                    print("glassNum=Double(count):",self.glassNum)
                }
                catch
                {
                    print(error)
                }
                self.animation()
                
            }) { (error) in
                print(error.localizedDescription)
                // في حالة التعثر في تنفيذ الامر السابق، سيتم طباعة الخطأ في الكونسل
            }
            // Do any additional setup after loading the view.
        })
        print("weightLet:",weightLet)
        
    }
    
    func createTable(){
        let crateTable = self.waterTable.create { (table) in
            table.column(self.idColumn, primaryKey: true)
            table.column(self.userIDColumn)
            table.column(self.ozColumn)
            table.column(self.weightColumn)
            table.column(self.date_timeColumn)
        }
        do{
            try self.database.run(crateTable)
            print("table(water) has been created.")
        }
        catch
        {
            print(error)
        }
    }
    
    func insertCup()
    {
        //let tomorrow2 = Calendar.current.date(byAdding: .day, value: -1, to: now)
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        //TimeZone
        components.timeZone = TimeZone(secondsFromGMT: 0)
        //Start of the day
        let today = gregorian.date(from: components)!
        
            let insertCup = self.waterTable.insert(self.ozColumn <- cupSize,self.userIDColumn <- usersID,self.weightColumn <- weightLet,self.date_timeColumn <- today)
            do{
                try self.database.run(insertCup)
                print("Inserted row.")
            }
            catch
            {
                print(error)
            }
    }
    
    func animation(){
        // Create Boat Animation
        let animetion = "female"
        boatAnimation = LOTAnimationView(name: animetion)
        // Set view to full screen, aspectFill
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleToFill
        boatAnimation!.frame = animationView.bounds
        //boatAnimation!.backgroundColor=UIColor.blue
        // Add the Animation
        animationView.addSubview(boatAnimation!)
        syncProgress()
    }
    
    
    /*
    func listUser(let startDay)
    {
        do{
            let waterlevel = try self.database.prepare(waterTable)
            let count = try self.database.scalar(waterTable.filter(date_timeColumn >= startDay).count)
            glassNum=count
            for todaylevel in waterlevel{
                print("userId: \(todaylevel[self.idColumn]),name: \(todaylevel[self.ozColumn]),email: \(todaylevel[self.date_timeColumn]),Date: \(todaylevel[self.weightColumn])")
                glassNum=
            }
        }
        catch
        {
            print(error)
        }
        
    }
    */

    @IBAction func AddOneCup(_ sender: Any) {
        
        cupSize=1.0
        
        glassNum=glassNum+cupSize
        insertCup()
        print("Int((100/neededGlasses)): ",((100/neededGlasses) * Double(glassNum)).rounded())
        print(((100/neededGlasses.rounded()) * Double(glassNum)).rounded()*0.01)
        syncProgress()
        
    }
    func syncProgress(){
        waterProgress.text=String(((100/neededGlasses.rounded()) * Double(glassNum)).rounded())+"%"
        var animeProgress=Double((100/neededGlasses.rounded()) * Double(glassNum)).rounded()*0.01
        if(animeProgress>1.0)
        {
            animeProgress=1.0
        }
        let  myFloat = NSNumber.init(value: animeProgress).floatValue
        let  myCGFloat = CGFloat(myFloat)
        //boatAnimation!.animationProgress=myCGFloat
        boatAnimation!.play(fromProgress: boatAnimation!.animationProgress, toProgress: myCGFloat, withCompletion: nil)
    }
    @IBAction func exitView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
