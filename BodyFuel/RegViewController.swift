


import UIKit

class RegViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonpressed(_ sender: UIButton) { performSegue(withIdentifier: "GoToHomeScreen", sender: self)
    }
    


}
