

import UIKit

class exerciseViewController: UIViewController {
    
     
     var workoutType=""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func upper(_ sender: Any) {
         workoutType="upper"
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBAction func MedPart(_ sender: Any) {
         workoutType="MedPart"
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBAction func LowerPart(_ sender: Any) {
        workoutType="LowerPart"
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workingoutViewController = segue.destination as! workingoutViewController
        workingoutViewController.text=workoutType
        print("Whats up:",workoutType)
    }
    @IBAction func exitView(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
  
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
