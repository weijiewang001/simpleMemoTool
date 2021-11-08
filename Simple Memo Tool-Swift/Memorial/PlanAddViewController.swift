//
//  PlanAddViewController.swift
//  Memorial
//
//  Created by Matin on 2021/4/4.
//

import UIKit

class PlanAddViewController: UIViewController {
    
    @IBOutlet weak var datePic: UIDatePicker!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置圆角
        addBtn.layer.cornerRadius = 10
        addBtn.layer.masksToBounds = true
        //设计日期控件语言
        datePic.locale = Locale(identifier: "TCB_Syd")
    }
    
    //添加事件
    @IBAction func addAction(_ sender: UIButton) {
        
        //判断是否已登录
//        if (UserDefaults.standard.object(forKey: "Username") == nil) {
//            self.view.makeToast("请先登录", duration: 1.5, position: .center)
//            return
//        }
        
        //判断如果输入的文字为空则提示输入文字
        if contentTextView.text.count > 0 {
            //获取时间
            let formatter = DateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let dateStr = formatter.string(from: datePic.date)
            
            let model = MemoModel.init(content: contentTextView.text, answer: dateStr)
            //发送通知，通知上个页面刷新数据
            NotificationCenter.default.post(name: NSNotification.Name(MT_Plan_NTF), object: self, userInfo: ["data":model as Any])
            //返回上个页面
            self.navigationController?.popViewController(animated: true)
        }else{
            self.view.makeToast("Please enter text", duration: 1.5, position: .center)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
