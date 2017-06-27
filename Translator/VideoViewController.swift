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
    var obj:Video?
    // MARK: *** UI Elements
    
    @IBOutlet weak var transView: UIView!
    
    @IBOutlet weak var secondLoop: UILabel!
    
    @IBOutlet weak var videoViewYT: YTPlayerView!
    
    @IBOutlet weak var sentence: UITextView!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var backText: UIButton!
    
    @IBOutlet weak var nextText: UIButton!
    
    @IBOutlet weak var backbackText: UIButton!
    
    @IBOutlet weak var nextnextText: UIButton!
    
    var sentences=[String]()
    var timeLoop:Float32=0
    var currentTime:Float32=0
    var indexCurrent:Int32=0
    var indexBack:Int32=0
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    let temp:CGFloat = 50
    var less:CGFloat?

    // MARK: *** UIViewController

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)

        let viewBtn = UIBarButtonItem(title: "View", style: .plain, target: self, action: #selector(viewTrans))
        navigationItem.rightBarButtonItem = viewBtn

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //let no = Notification.init(name: NSNotification.Name.UIKeyboardWillShow)
        
        timeLoop=Float32((obj?.timeLoop)!)
        currentTime=Float32((obj?.timePlaying)!)
        
        videoViewYT.load(withVideoId: (obj?.link!)!, playerVars: ["playsinline": 1 as AnyObject])
        videoViewYT.seek(toSeconds: currentTime, allowSeekAhead: true)
        
        
        var timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("loop"), userInfo: nil, repeats: true)
        
        
        
        sentences=(obj?.translated?.components(separatedBy: ["`"]))!
        sentences.popLast()
        indexCurrent=Int32(sentences.count)
        indexBack=indexCurrent
       
        if sentences.count != 0{
            sentence.text=sentences[sentences.count-1]
        }
        else{
            indexCurrent+=1
            indexBack+=1
            sentence.text=""
        }
         status.text=String(indexBack)+"/"+String(indexCurrent)
        if indexBack==1 {
            backText.isEnabled=false
            backbackText.isEnabled=false
        }

    }
    
    func viewTrans() {
        saveTrans()
        
        let storyB = UIStoryboard.init(name: "Play", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "ViewTransVC") as! ViewTransViewController
        vc.setView(name: obj!.name!, text: obj!.translated!)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveTrans() {
        if Int(indexCurrent) != sentences.count {
            addNew()
        }
        
        var tempText: String = ""
        for i in 0..<sentences.count {
            tempText +=  sentences[i]+"`"
        }
        obj?.translated? = tempText
        obj?.timeLoop=Int32(timeLoop)
        obj?.timePlaying=Int32(currentTime)
        obj?.speed=1
        DB.save()

    }
    
    func screenCurrent(){
        
        if indexBack==indexCurrent && Int(indexBack) == sentences.count{
            sentence.text=sentences[Int(indexBack)-1]
        }
        else if indexBack==indexCurrent && Int(indexBack) != sentences.count{
            sentence.text=""
        }
        else {
            sentence.text=sentences[Int(indexBack)-1]
        }
        if indexBack > 1 {
            backText.isEnabled=true
            backbackText.isEnabled=true
        }
        status.text=String(indexBack)+"/"+String(indexCurrent)
        
        
    }
    
    func addNew(){
        sentences.append(sentence.text)
    }
    func setEdit(){
        sentences[Int(indexBack)-1]=sentence.text!
    }
    @IBAction func nextSecond(_ sender: Any) {
        if sentence.text == "" {
            
            return
        }
        
        if indexBack==indexCurrent && Int(indexBack) != sentences.count{
          
            indexBack+=1
            indexCurrent+=1
            addNew()
        }
        else if indexBack==indexCurrent && Int(indexBack) == sentences.count{
            setEdit()
            indexBack+=1
            indexCurrent+=1
        }
        else {
            setEdit()
            indexBack+=1
        }
        
        screenCurrent()
        
        view.endEditing(true)
    }
    

    
    @IBAction func backSecond(_ sender: Any) {
        if sentence.text=="" && indexBack != indexCurrent{
            return
        }
        if indexBack==indexCurrent && Int(indexBack) != sentences.count{
            indexBack-=1
            addNew()
        }
        else {
            setEdit()
            indexBack-=1
        }
        screenCurrent()
        if indexBack==1 {
            backText.isEnabled=false
            backbackText.isEnabled=false
        }
        
        view.endEditing(true)

    }
    
    @IBAction func sentenceCurrent(_ sender: Any) {
        indexBack=indexCurrent
        if Int(indexCurrent) > sentences.count {
            addNew()
        }
        screenCurrent()
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
    
    
    @IBAction func sentenceStart(_ sender: Any) {
        indexBack=1
        backText.isEnabled=false
        backbackText.isEnabled=false
        
        if Int(indexCurrent) > sentences.count {
            addNew()
        }
       screenCurrent()
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

    
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        saveTrans()
    }
    
    func updateDataVideo(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        
    }
    

    func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        let sizeC = transView.frame.height + videoViewYT.frame.height
        less = keyboardSize.height - (view.frame.height - sizeC)
        if less! > CGFloat(0) {
            videoViewYT.frame = CGRect(x: videoViewYT.frame.origin.x, y: videoViewYT.frame.origin.y, width: videoViewYT.frame.width, height: videoViewYT.frame.height - less! - temp)
            transView.frame.origin.y -= less! + temp
        }
    }
}
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if less! > CGFloat(0) {
                videoViewYT.frame = CGRect(x: videoViewYT.frame.origin.x, y: videoViewYT.frame.origin.y, width: videoViewYT.frame.width, height: videoViewYT.frame.height + less! + temp)
                transView.frame.origin.y += less! + temp
                
                less = 0
            }
        }
    }

}
