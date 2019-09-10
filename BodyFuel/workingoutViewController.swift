

import UIKit

class workingoutViewController: UIViewController {
    var text: String? = nil
    var time = 0.0
    var runTimedCode = Timer()
    
    @IBOutlet weak var Scroll: UIScrollView!
    @IBOutlet weak var timerLabe: UILabel!
    //
    @IBOutlet weak var workout01label: UILabel!
    @IBOutlet weak var workout01image: UIImageView!
    @IBOutlet weak var workout01desc: UILabel!
    @IBOutlet weak var workout02label: UILabel!
    @IBOutlet weak var workout02image: UIImageView!
    @IBOutlet weak var workout03label: UILabel!
    
    @IBOutlet weak var workout03desc: UILabel!
    @IBOutlet weak var workout03image: UIImageView!
    @IBOutlet weak var workout02Desc: UILabel!
    @IBOutlet weak var workout04image: UIImageView!
    @IBOutlet weak var workout04desc: UILabel!
    
    @IBOutlet weak var workout04label: UILabel!
    
    let red = UIColor(red: 154/255.0, green: 184/255.0, blue: 157/255.0, alpha: 1.0)
    override func viewDidLoad() {
        
        
        
        Scroll.layer.borderWidth=3
        Scroll.layer.borderColor = red.cgColor
        //timerLabe.textColor=red
        //view.backgroundColor=red
        //view.backgroundColor = UIColorFromRGB(rgbValue: 0x209624)
        
        print("text:",text)
        if(text=="upper")
        {
        workout01image.image = #imageLiteral(resourceName: "9")
        workout02image.image = #imageLiteral(resourceName: "8")
            workout03image.image = #imageLiteral(resourceName: "1")
            workout04image.image = #imageLiteral(resourceName: "7")
            workout01label.text="البايسبس"
            workout02label.text="اكتاف بالدمبل"
            workout03label.text="سحب الكيبل"
            workout04label.text="الضغط"
           workout01desc.text="هي عضلة الذراع الاساسية"
            workout02Desc.text="تمرين مسؤل عن عضلة سطح الكتف"
            workout03desc.text="وهو تمرين مفيد جدا لعضلة الظهر"
            workout04desc.text="من اقوى تمارين شد الصدر"
        }
        else if(text=="MedPart"){
            workout01image.image = #imageLiteral(resourceName: "6")
            workout02image.image = #imageLiteral(resourceName: "4")
            workout03image.image = #imageLiteral(resourceName: "5")
            workout04image.image = #imageLiteral(resourceName: "12")
            workout01label.text="الجلسة المطواة"
            workout02label.text="سحب الساقين"
            workout03label.text="الأكتماء"
            workout04label.text="الصعود العالي"
            workout01desc.text="جلسة تشد عضلات البطن"
            workout02Desc.text="سحب الساق للمعدة"
            workout03desc.text="تمرين لشد العضلات العلوية"
            workout04desc.text="تمرين عضلة ما بين الفخذ والمعدة"
        }
        else if(text=="LowerPart"){
            workout01image.image = #imageLiteral(resourceName: "11")
            workout02image.image = #imageLiteral(resourceName: "3")
            workout03image.image = #imageLiteral(resourceName: "10")
            workout04image.image = #imageLiteral(resourceName: "4")
            workout01label.text="سكوات"
            workout02label.text="التحليق"
            workout03label.text="سكوات - مشينس"
            workout04label.text="تمارين منزلية"
            workout01desc.text="تمرين زوائد الجسم الي على جنب"
            workout02Desc.text="سمي بالتحلق لتشابهه مع السيران"
            workout03desc.text="استخدام الجهاز بامكانا رفع سريغ"
            workout04desc.text="تمرين الجري"
        }
        print(text!)
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    @IBAction func stop(_ sender: Any) {
        runTimedCode.invalidate()
        time=0.0
        timerLabe.text="0.0"
    }
    
    @IBAction func startTimer(_ sender: Any) {
        runTimedCode = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CLOCK), userInfo: nil, repeats: true)
    }
    @IBAction func pauseTimer(_ sender: Any) {
        runTimedCode.invalidate()
    }
    @objc func CLOCK()
    {
        
        print(time)
        time+=0.1
        timerLabe.text="\(time)"
    }
    @IBAction func exitVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
