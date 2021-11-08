

import UIKit

class AccountAddViewController: UIViewController {

    @IBOutlet weak var contentFld: UITextField!
    @IBOutlet weak var moneyFld: UITextField!
    @IBOutlet weak var typeBtn: UIButton!
    var typeStr: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //type button
    @IBAction func typeAction(_ sender: UIButton) {
        weak var weakSelf = self
        let changeCon = UIAlertController()
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let act = UIAlertAction(title: "outcome", style: .default) { (action) in
            weakSelf?.typeBtn.setTitle("outcome", for: .normal)
            weakSelf?.typeStr = "outcome"
        }
        let focusOnAction = UIAlertAction(title: "income", style: .default) { (action) in
            weakSelf?.typeBtn.setTitle("income", for: .normal)
            weakSelf?.typeStr = "income"
        }
        
        changeCon.addAction(focusOnAction)
        changeCon.addAction(act)
        changeCon.addAction(cancelAction)
        weakSelf!.present(changeCon, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        

        if (contentFld.text!.count == 0) {
            self.view.makeToast("Please enter content here", duration: 1.5, position: .center)
            return
        }
        
        if (moneyFld.text!.count == 0) {
            self.view.makeToast("amount here", duration: 1.5, position: .center)
            return
        }
        
        if (typeStr.length == 0) {
            self.view.makeToast("Type", duration: 1.5, position: .center)
            return
        }
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from: date)
        
        let model = AccountBookModel.init(content: contentFld.text!, time: dateStr, money: moneyFld.text!, typeStr: typeStr as String)
        //send update request
        NotificationCenter.default.post(name: NSNotification.Name(MT_AccountBook_NTF), object: self, userInfo: ["data":model as Any])
        //back to last page
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
