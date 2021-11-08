
import UIKit

class MemoListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "memo"
    var dataArr = [MemoModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //notify
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: MT_Memo_NTF), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //register cell
        let nib = UINib(nibName: "MemoListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        //loading data
        if let saveModels = loadModels() {
            dataArr += saveModels
        }
    }
    
    //get local data
    func loadModels() -> [MemoModel]? {
        let records = NSKeyedUnarchiver.unarchiveObject(withFile: MemoModel.MemoArchiveURL.path) as? [MemoModel]
        return records
//            NSKeyedUnarchiver.unarchiveObject(withFile: MemoModel.MemoArchiveURL.path) as? [MemoModel]
    }
    
    //accept refresh notification
    @objc func loadData(nofi:Notification) {
        let obj = nofi.userInfo!["memo"]
        
        let newIndexPath = IndexPath(row: dataArr.count, section: 0)
        dataArr.append(obj as! MemoModel)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        saveModel()
    }
    
    //save data
    func saveModel() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataArr, toFile: MemoModel.MemoArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save...")
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveModel()
        } else if editingStyle == .insert {

        }
    }


}
