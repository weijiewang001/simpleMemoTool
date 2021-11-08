//
//  PlanViewController.swift
//  Memorial
//
//  Created by Matin on 2021/4/4.
//

import UIKit

class PlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellID = "plan"
    var dataArr = [MemoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取消分割线
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //判断是否已登录
//        if (UserDefaults.standard.object(forKey: "Username") == nil) {
//            return
//        }

        //接受通知
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: MT_Plan_NTF), object: nil)
        
        //设置tableview代理
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        let nib = UINib(nibName: "MemoListTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        //加载数据
        if let saveModels = loadModels() {
            dataArr += saveModels
        }
    }
    
    //获取本地数据
    func loadModels() -> [MemoModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MemoModel.PlanArchiveURL.path) as? [MemoModel]
    }
    
    //接受通知刷新数据
    @objc func loadData(nofi:Notification) {
        let obj = nofi.userInfo!["data"]
        
        let newIndexPath = IndexPath(row: dataArr.count, section: 0)
        dataArr.append(obj as! MemoModel)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        saveModel()
    }
    
    //保存数据
    func saveModel() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataArr, toFile: MemoModel.PlanArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save pops...")
        }
    }
    
    //行的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MemoListTableViewCell
        let dataModel = self.dataArr[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentLab.text = dataModel.contentStr
        
        //计划时间转为时间戳
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        format.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = format.date(from: dataModel.timeStr!)
        let planDate = date!.timeIntervalSince1970
        
        //获取当前时间戳
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
    
    //设置哪些行可以编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 设置单元格的编辑的样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //设置点击删除之后的操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveModel()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "breathe", sender: dataArr[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "breathe" {
            let detailVC = segue.destination as! BreatheViewController
            detailVC.planModel = sender as? MemoModel
        }
    }

}
