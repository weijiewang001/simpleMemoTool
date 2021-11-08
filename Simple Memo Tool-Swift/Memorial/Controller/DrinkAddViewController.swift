

import UIKit

class DrinkAddViewController: UIViewController {

    @IBOutlet weak var drinkingFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        

        
        if drinkingFld.text!.count > 0 {
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateStr = timeFormatter.string(from: date)
            
            let model = MemoModel.init(content: drinkingFld.text!+"ml", answer: dateStr)
            NotificationCenter.default.post(name: NSNotification.Name(MT_Drink_NTF), object: self, userInfo: ["data":model as Any])

            self.navigationController?.popViewController(animated: true)
        }else{
            self.view.makeToast("Please enter water amount here", duration: 1.5, position: .center)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    


}
