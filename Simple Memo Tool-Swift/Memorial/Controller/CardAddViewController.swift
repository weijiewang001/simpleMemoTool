

import UIKit

class CardAddViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLab: UILabel!
    var dataArr : NSArray!
    let cellId = "planList"
    var selectStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataArr = ["Learn swift API","Play with Leetcode","play Bubble Pop","do IOS homework"]
        currentDate()
        custonTableView()
    }
    
    func currentDate() {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLab.text = timeFormatter.string(from: date)
    }
    
    func custonTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let nib = UINib(nibName: "PlanListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlanListTableViewCell
        cell.contentLab.text = dataArr[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectStr = dataArr[indexPath.row] as! String
    }
    
    
    @IBAction func addAction(_ sender: UIButton) {
        

        
        if selectStr.count > 0 {
            
            let model = MemoModel.init(content: selectStr, answer: dateLab.text!)

            NotificationCenter.default.post(name: NSNotification.Name(MT_Card_NTF), object: self, userInfo: ["data":model as Any])

            self.navigationController?.popViewController(animated: true)
        }else{
            self.view.makeToast("please select type", duration: 1.5, position: .center)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
