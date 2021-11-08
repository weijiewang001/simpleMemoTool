

import UIKit

class AccountBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "accountBook"
    var dataArr = [AccountBookModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: MT_AccountBook_NTF), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "AccountBookTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)

        if let saveModels = loadModels() {
            dataArr += saveModels
        }
    }
    
    func loadModels() -> [AccountBookModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: AccountBookModel.AccountBookArchiveURL.path) as? [AccountBookModel]
    }
    
    @objc func loadData(nofi:Notification) {
        let obj = nofi.userInfo!["data"]
        
        let newIndexPath = IndexPath(row: dataArr.count, section: 0)
        dataArr.append(obj as! AccountBookModel)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        saveModel()
    }
    
    //refer from https://www.jianshu.com/p/83d118aa43b3
    func saveModel() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataArr, toFile: AccountBookModel.AccountBookArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save pops...")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AccountBookTableViewCell
        let dataModel = self.dataArr[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentLab.text = dataModel.contentStr
        cell.moneyLab.text = "$" + dataModel.moneyStr!
        cell.typeLab.text = dataModel.typeStr
        cell.timeLab.text = dataModel.timeStr
        return cell
    }
    


}
