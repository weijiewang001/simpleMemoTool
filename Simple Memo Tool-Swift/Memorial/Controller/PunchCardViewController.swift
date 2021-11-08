

import UIKit

class PunchCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "memo"
    var dataArr = [MemoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: MT_Card_NTF), object: nil)

        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MemoListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)

        if let saveModels = loadModels() {
            dataArr += saveModels
        }
    }
    
    func loadModels() -> [MemoModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MemoModel.CardArchiveURL.path) as? [MemoModel]
    }
    
    @objc func loadData(nofi:Notification) {
        let obj = nofi.userInfo!["data"]
        
        let newIndexPath = IndexPath(row: dataArr.count, section: 0)
        dataArr.append(obj as! MemoModel)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        saveModel()
    }
    
    func saveModel() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataArr, toFile: MemoModel.CardArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save pops...")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MemoListTableViewCell
        let dataModel = self.dataArr[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentLab.text = dataModel.contentStr
        cell.timeLab.text = dataModel.timeStr
        return cell
    }
    
    
    @IBAction func pushCardAction(_ sender: UIButton) {
    }
    

}
