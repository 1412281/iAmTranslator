//
//  VideoViewController.swift
//  Translator
//
//  Created by LamTran on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class VideoViewController: UIViewController {
    
    var timeLoop:Float32=0
    var currentTime:Float32=0
    // MARK: *** Data model
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var videoView: YTPlayerView!
   
    @IBOutlet weak var secondLoop: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        timeLoop=Float32(secondLoop.text!)!
        videoView.setPlaybackRate(2000)
         videoView.load(withVideoId: "-nnWBhKZeg0", playerVars: ["playsinline": 1 as AnyObject])
        var timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("loop"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func loadVideo(_ sender: Any) {
        
    }

    @IBAction func playCurrent(_ sender: Any) {
      videoView.seek(toSeconds: currentTime, allowSeekAhead: true)
        videoView.playVideo()
    }
    
    @IBAction func increaseSecond(_ sender: Any) {
        var second = Int32(secondLoop.text!)!
        if second == 59{
            return
        }
        else {
            second += 1
            secondLoop.text=String(describing: second)
        }
        
        
    }
    
    @IBAction func decreaseSecond(_ sender: Any) {
        var second = Int32(secondLoop.text!)!
        //var second=1;
        if second == 0{
            return
        }
        else {
            second -= 1
            secondLoop.text=String(describing: second)
        }

    }
    
    
    @IBAction func timereStart(_ sender: Any) {
        currentTime=videoView.currentTime()
       videoView.seek(toSeconds: 0, allowSeekAhead: true)
        videoView.playVideo()
    }
    
    
    @IBAction func back(_ sender: Any) {
        var getSecond=Float32(secondLoop.text!)!
        var timeBack=videoView.currentTime()-getSecond
        videoView.seek(toSeconds: timeBack, allowSeekAhead: true)
        videoView.playVideo()
      
    }
    
    
    @IBAction func next(_ sender: Any) {
        var getSecond=Float32(secondLoop.text!)!
        var timeBack=videoView.currentTime()+getSecond
        videoView.seek(toSeconds: timeBack, allowSeekAhead: true)
        videoView.playVideo()
        
    }
    func loop(){
       var second=Float32(secondLoop.text!)!
        if second == 0 {
            return
        }
        timeLoop-=1
        if timeLoop==0{
            var timeBack=videoView.currentTime() - second
            videoView.seek(toSeconds: timeBack, allowSeekAhead: true)
            videoView.playVideo()
            timeLoop=second
        }
    }
    @IBAction func speed(_ sender: Any) {
        videoView.setPlaybackRate(0.5)
    }
    
   
}
