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
  
    var ref: DatabaseReference!
    
    @IBOutlet weak var link: UITextField!
    
    @IBOutlet weak var name: UITextField!
    var timer:Timer!
    
    @IBAction func play(_ sender: Any) {
        let resultLink = link.text!.components(separatedBy: ["/"])
        view.endEditing(true)
        videoAddTest.load(withVideoId: resultLink[resultLink.count-1], playerVars: ["playsinline": 1 as AnyObject])
        //videoAddTest.playVideo()
        
        
    }
    
    func AddDatabase(link:String!,data:Video){
        ref = Database.database().reference()
        
        print(nameUser)
        let resultLink = nameUser!.components(separatedBy: ["@"])
        let link = "/" + resultLink[0] + "/video/video1"
        
        ref.child(link+"/name").setValue(data.name)
        ref.child(link+"/length").setValue(data.length)
        ref.child(link+"/speed").setValue(data.speed)
        ref.child(link+"/timeLoop").setValue(data.timeLoop)
        ref.child(link+"/timePlaying").setValue(data.timePlaying)
        ref.child(link+"/translated").setValue(data.translated)
        ref.child(link+"/link").setValue(data.link)
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
        let resultLink = link.text!.components(separatedBy: ["/"])
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
        
        
        
        let resultLink = link.text!.components(separatedBy: ["/"])
        
        let newV = Video.create() as! Video
        newV.name = name.text!
        newV.translated = ""
        newV.link = resultLink[resultLink.count-1]
        newV.timeLoop = 10
        newV.timePlaying = 0
        newV.speed = 1
        
 
        var duration = videoAddTest.duration()
        newV.length=duration
        
        AddDatabase(link: "/1", data: newV)
        
        DB.save()
        
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
