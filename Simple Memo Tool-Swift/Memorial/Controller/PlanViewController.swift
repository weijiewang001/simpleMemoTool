

import UIKit

class PlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "plan"
    var dataArr = [MemoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none


        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: MT_Plan_NTF), object: nil)

        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "MemoListTableViewCell", bundle: nil) 
        tableView.register(nib, forCellReuseIdentifier: cellID)

        if let saveModels = loadModels() {
            dataArr += saveModels
        }
    }
    
    func loadModels() -> [MemoModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MemoModel.PlanArchiveURL.path) as? [MemoModel]
    }

    @objc func loadData(nofi:Notification) {
        let obj = nofi.userInfo!["data"]
        
        let newIndexPath = IndexPath(row: dataArr.count, section: 0)
        dataArr.append(obj as! MemoModel)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        saveModel()
    }
    
    func saveModel() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataArr, toFile: MemoModel.PlanArchiveURL.path)
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
        
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        format.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = format.date(from: dataModel.timeStr!)
        let planDate = date!.timeIntervalSince1970
        
        let  dat:Date = Date.init(timeIntervalSinceNow: 0)
        let  a:TimeInterval = dat.timeIntervalSince1970;
        
        let intervalTime = Int(planDate - a)
        if intervalTime>0 {
            if intervalTime/(60*60*60) > 0 {
                cell.timeLab.text = "Countdown" + String(intervalTime/(60*60*60)) + "d"
            }else if (intervalTime/(60*60) > 0 && intervalTime/(60*60*60) < 1){
                cell.timeLab.text = "Countdown" + String(intervalTime/(60*60)) + "h"
            }else if (intervalTime/(60) > 0 && intervalTime/(60*60) < 1){
                cell.timeLab.text = "Countdown" + String(intervalTime/(60)) + "m"
            }else if (intervalTime/60 < 1){
                cell.timeLab.text = "Countdown" + String(intervalTime) + "s"
            }
        }else{
            cell.timeLab.text = "Plan expired"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    // Delete the data from the data source
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveModel()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    


}
