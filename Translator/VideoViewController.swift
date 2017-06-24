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

    // MARK: *** Data model
    var link: String = "-nnWBhKZeg0"
    var trans: String = ""
    var speed: Int = 1
    // MARK: *** UI Elements
    
    @IBOutlet weak var transView: UIView!
    
    @IBOutlet weak var secondLoop: UILabel!
    
    @IBOutlet weak var videoViewYT: YTPlayerView!
    
    var timeLoop:Float32=0
    var currentTime:Float32=0
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        timeLoop=Float32(secondLoop.text!)!
        videoViewYT.setPlaybackRate(2000)
        videoViewYT.load(withVideoId: link, playerVars: ["playsinline": 1 as AnyObject])
        var timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("loop"), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func playCurrent(_ sender: Any) {
        videoViewYT.seek(toSeconds: currentTime, allowSeekAhead: true)
        videoViewYT.playVideo()
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
        currentTime=videoViewYT.currentTime()
        videoViewYT.seek(toSeconds: 0, allowSeekAhead: true)
        videoViewYT.playVideo()
    }
    
    
    @IBAction func back(_ sender: Any) {
        var getSecond=Float32(secondLoop.text!)!
        var timeBack=videoViewYT.currentTime()-getSecond
        videoViewYT.seek(toSeconds: timeBack, allowSeekAhead: true)
        videoViewYT.playVideo()
        
    }
    
    
    @IBAction func next(_ sender: Any) {
        var getSecond=Float32(secondLoop.text!)!
        var timeBack=videoViewYT.currentTime()+getSecond
        videoViewYT.seek(toSeconds: timeBack, allowSeekAhead: true)
        videoViewYT.playVideo()
        
    }
    func loop(){
        var second=Float32(secondLoop.text!)!
        if second == 0 {
            return
        }
        timeLoop-=1
        if timeLoop==0{
            var timeBack=videoViewYT.currentTime() - second
            videoViewYT.seek(toSeconds: timeBack, allowSeekAhead: true)
            videoViewYT.playVideo()
            timeLoop=second
        }
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let sizeC = transView.frame.height + videoViewYT.frame.height
            let less = keyboardSize.height - (view.frame.height - sizeC)
                videoViewYT.frame = CGRect(x: videoViewYT.frame.origin.x, y: videoViewYT.frame.origin.y, width: videoViewYT.frame.width, height: videoViewYT.frame.height - less - 40)
                transView.frame.origin.y -= less + 40
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.transView.frame.origin.y += (keyboardSize.height - 40)
            }
        }
    }

}
