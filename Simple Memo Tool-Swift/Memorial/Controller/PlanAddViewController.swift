

import UIKit

class PlanAddViewController: UIViewController {
    
    @IBOutlet weak var datePic: UIDatePicker!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //corner
        addBtn.layer.cornerRadius = 10
        addBtn.layer.masksToBounds = true
        datePic.locale = Locale(identifier: "TBC_Syd")
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        

        
        if contentTextView.text.count > 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let dateStr = formatter.string(from: datePic.date)
            
            let model = MemoModel.init(content: contentTextView.text, answer: dateStr)

            NotificationCenter.default.post(name: NSNotification.Name(MT_Plan_NTF), object: self, userInfo: ["data":model as Any])

            self.navigationController?.popViewController(animated: true)
        }else{
            self.view.makeToast("Please enter text", duration: 1.5, position: .center)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}
