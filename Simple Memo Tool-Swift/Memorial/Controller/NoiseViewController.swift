

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

        startBtn.clipsToBounds = true
        startBtn.layer.cornerRadius = 15
        
        pauseBtn.clipsToBounds = true
        pauseBtn.layer.cornerRadius = 15
        
        dataArr = ["Water channel","pond","rain","water","Wood"]
        contentArr = ["White noise 1","White noise 2","White noise 3","White noise 4","White noise 5"]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let nib = UINib(nibName: "NoiseTableViewCell", bundle: nil)
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
        do{
            
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            try audioPlayer = AVAudioPlayer(contentsOf:soundUrl,fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print(error)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NoiseTableViewCell
        cell.contentLab.text = contentArr[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noiseStr = dataArr[indexPath.row] as! String
    }
}
