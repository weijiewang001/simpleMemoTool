//
//  NoiseViewController.swift
//  Memorial
//
//  Created by Matin on 2021/4/6.
//

import UIKit
import AVFoundation

class NoiseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let cellID = "noise"
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var dataArr: NSArray!
    var contentArr: NSArray!
    var noiseStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //切圆角
        startBtn.clipsToBounds = true
        startBtn.layer.cornerRadius = 15
        
        pauseBtn.clipsToBounds = true
        pauseBtn.layer.cornerRadius = 15
        
        dataArr = ["Water channel","pond","rain","water","Wood"]
        contentArr = ["White noise 1","White noise 2","White noise 3","White noise 4","White noise 5"]
        
        //设置tableview代理
        tableView.delegate = self
        tableView.dataSource = self
        //取消分割线
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //注册cell
        let nib = UINib(nibName: "NoiseTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        audioPlayer.pause()
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        if noiseStr.count == 0 {
            self.view.makeToast("Please choose white noise", duration: 1.5, position: .center)
            return
        }
        playLocalMusic(name: noiseStr)
    }
    
    func playLocalMusic(name: String) {
        
        let path = Bundle.main.path(forResource: name, ofType: "mp3")
        let soundUrl = URL(fileURLWithPath: path!)
        
        let session = AVAudioSession.sharedInstance()
        //在音频播放前首先创建一个异常捕捉语句
        do{
            
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            //对音频播放对象进行初始化，并加载指定的音频播放对象
            try audioPlayer = AVAudioPlayer(contentsOf:soundUrl,fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.prepareToPlay()
            //设置音频对象播放的音量的大小
            audioPlayer.volume = 1.0
            //设置音频播放的次数，-1为无限循环播放
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print(error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NoiseTableViewCell
        cell.contentLab.text = contentArr[indexPath.row] as? String
        
        return cell
    }
    
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noiseStr = dataArr[indexPath.row] as! String
    }
}
