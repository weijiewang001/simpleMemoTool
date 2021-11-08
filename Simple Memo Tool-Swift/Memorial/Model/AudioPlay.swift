

import UIKit
import AVFoundation

class AudioPlay: NSObject {
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    func playLocalMusic() {
        let path = Bundle.main.path(forResource: "Wood", ofType: "mp3")
                //        public init(fileURLWithPath path: String)
        let soundUrl = URL(fileURLWithPath: path!)
        
        let session = AVAudioSession.sharedInstance()
        //Create an exception catch statement before the audio is played
        do{
            
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            //Initialize the audio playback object and load the specified audio playback object
            try audioPlayer = AVAudioPlayer(contentsOf:soundUrl,fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print(error)
        }
    }
}
