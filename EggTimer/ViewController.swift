//
//  ViewController.swift
//  EggTimer
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = [ "Soft": 300, "Medium": 420, "Hard": 720 ]
    var time: Int?
    var initialTime: Int?
    var timer: Timer? = nil
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        if timer != nil { return }
        
        titleLabel.text = "How do you like your eggs?"
        progressBar.progress = 0.0
        
        let hardness = sender.currentTitle ?? "No Title"
        
        // print(eggTimes[hardness]!)
            // this is a better solution provided in video
        
        time = eggTimes[hardness]
        initialTime = eggTimes[hardness]
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeCounter() {
        print(time!)
        time! -= 1
        progressBar.progress = 1.0 - Float(time!) / Float(initialTime!)
        
        if time! < 0 {
            timer?.invalidate()
            timer = nil
            time = 0
            print("Done!")
            titleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
