//
//  AddVideoViewController.swift
//  Translator
//
//  Created by LamTran on 6/20/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Foundation
import youtube_ios_player_helper
import Firebase
class AddVideoViewController: UIViewController {
  
    @IBOutlet weak var viewLoad: UIView!
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var link: UITextField!
    
    @IBOutlet weak var name: UITextField!
    var timer:Timer!
    
    @IBAction func play(_ sender: Any) {
        let fixlink = link.text!.replacingOccurrences(of: "watch?v=", with: "")
        print(fixlink)

        let resultLink = fixlink.components(separatedBy: ["/"])
        view.endEditing(true)
        videoAddTest.load(withVideoId: resultLink[resultLink.count-1], playerVars: ["playsinline": 1 as AnyObject])
        //videoAddTest.playVideo()
        
        
    }
    
    
    @IBOutlet weak var videoAddTest: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.title = "Add Video"
        navigationController?.setNavigationBarHidden(false, animated: true)
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton(sender:)))
        navigationItem.rightBarButtonItem = saveButton

        
        
        // Do any additional setup after loading the view.
    }
    func saveButton(sender: UIBarButtonItem) {
        
        if (link.text == "" || name.text == "") {
            return
        }
        
        
        let gif = UIImage.gifImageWithName("loading")
        let loadImg = UIImageView(image: gif)
        loadImg.layer.cornerRadius = 80
        loadImg.layer.masksToBounds = true
        loadImg.frame = CGRect(x: 50.0, y: 70.0, width: self.view.frame.size.width - 100, height: 200.0)
        viewLoad.addSubview(loadImg)
        viewLoad.isHidden = false
        view.bringSubview(toFront: viewLoad)
        
        let fixlink = link.text!.replacingOccurrences(of: "watch?v=", with: "")
        print(fixlink)

        let resultLink = fixlink.components(separatedBy: ["/"])
         videoAddTest.load(withVideoId: resultLink[resultLink.count-1], playerVars: ["playsinline": 1 as AnyObject])
         timer=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector("loop"), userInfo: nil, repeats: true)
        
        
        
       
    }
    func AlertSuccess(){
        let alert = UIAlertController(title: "Notification", message: "Add video successfully ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addVideo() {
        
        let fixlink = link.text!.replacingOccurrences(of: "watch?v=", with: "")
        print(fixlink)
        let resultLink = fixlink.components(separatedBy: ["/"])
        
        let newV = Video.create() as! Video
        newV.name = name.text!
        newV.translated = ""
        newV.link = resultLink[resultLink.count-1]
        newV.timeLoop = 10
        newV.timePlaying = 0
        newV.speed = 1
        newV.date = NSDate()
 
        var duration = videoAddTest.duration()
        newV.length=duration
        
        AddDatabase(data: newV)
        
        DB.save()
        
    }
    
    func AddDatabase(data:Video){
        ref = Database.database().reference()
        
        print(nameUser)
        let resultLink = nameUser!.components(separatedBy: ["@"])
        let link = "/" + resultLink[0] + "/video/" + data.date.toString()
        
        ref.child(link+"/name").setValue(data.name)
        ref.child(link+"/length").setValue(data.length)
        ref.child(link+"/speed").setValue(data.speed)
        ref.child(link+"/timeLoop").setValue(data.timeLoop)
        ref.child(link+"/timePlaying").setValue(data.timePlaying)
        ref.child(link+"/translated").setValue(data.translated)
        ref.child(link+"/link").setValue(data.link)
        ref.child(link+"/date").setValue(data.date.toString())

    }

    
    func loop(){
        
        videoAddTest.playVideo()
        videoAddTest.pauseVideo()
        if videoAddTest.currentTime() != 0 {
            addVideo()
            navigationController?.popViewController(animated: true)
            timer.invalidate()
            timer=nil
        }
    }

}
