//
//  PlayViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import CoreData

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: *** Data model
    var listText = [Text]()
    var listVideo = [Video]()
    // MARK: *** Local variables
    
    enum `Type` {
        case recent
        case text
        case video
    }
    var currentChoice = Type.text
   

      // MARK: *** UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var menuButton: UIView!
    @IBOutlet weak var selectAddView: UIView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    // MARK: *** UI events
    @IBAction func addButton(_ sender: Any) {
        self.selectAddView.isHidden = false
        view.bringSubview(toFront: backgroundView)
        view.bringSubview(toFront: selectAddView)
        backgroundView.alpha = 0.85
        
    }
    
    @IBAction func allButton(_ sender: Any) {
        currentChoice = Type.recent
        reloadView()
    }
    @IBAction func textButton(_ sender: Any) {
        currentChoice = Type.text
        reloadView()
    }
    
    @IBAction func videoButton(_ sender: Any) {
        currentChoice = Type.video
        reloadView()
    }
    
    
        // MARK: *** UIViewController

    override func viewDidLoad() {
        Dictionary.init()
        super.viewDidLoad()
        self.selectAddView.isHidden = true
        
        let touchToHiddenSelectAdd = UITapGestureRecognizer(target: self, action: #selector(PlayViewController.hiddenAdd))
        self.backgroundView.addGestureRecognizer(touchToHiddenSelectAdd)
        
        initData()
        
    }
    
    func hiddenAdd() {
        self.selectAddView.isHidden = true
        view.bringSubview(toFront: menuButton)
        view.bringSubview(toFront: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        listText = Text.all() as! [Text]
        listVideo = Video.all() as! [Video]
        
        reloadView()
        
        tableView.reloadData()

        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentChoice {
        case .text:
            return listText.count
        default:
            return listVideo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentChoice {
        
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextPlayCell") as! TextPlayTableViewCell
            cell.name.text = listText[indexPath.row].name
            cell.des.text = listText[indexPath.row].text
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayCell") as! VideoPlayTableViewCell
            cell.name.text = listVideo[indexPath.row].name
            cell.des.text = listVideo[indexPath.row].link
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChoice {
        case .text, .recent:
            let storyB = UIStoryboard(name: "Text", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "TextView") as! TextViewController
            
            let textObj = listText[indexPath.row]
            vc.originText = textObj.text!
            if let translated = textObj.translated{
                vc.translated = translated
            }
            vc.currentTran = Int(textObj.indexCurrent)
            
            navigationController?.pushViewController(vc, animated: true)
        case .video:
            let storyB = UIStoryboard(name: "Video", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "VideoView") as! VideoViewController
            
            let videoObj = listVideo[indexPath.row]
            vc.link = videoObj.link!
            vc.currentTime = Float32(videoObj.timePlaying)
            vc.speed = Int(videoObj.speed)
            vc.timeLoop = Float32(videoObj.timeLoop)
            
            
            navigationController?.pushViewController(vc, animated: true)

       
        }
    }
    
    
    //MARK: *** Help function
    func changeButton(){
        textButton.backgroundColor = nil
        videoButton.backgroundColor = nil
        switch currentChoice {
        case .text:
            textButton.backgroundColor = UIColor.green
        default:
            videoButton.backgroundColor = UIColor.green

        }
    }

    func reloadView() {
        changeButton()
        tableView.reloadData()
    }
    
    func initData() {
        
        Text.deleteAllRecords()
        Video.deleteAllRecords()
        for i in 1...10 {
            let newT = Text.create() as! Text
            newT.name = "text" + String(i)
            newT.text =  "The panel based their decisions on first impressions, unusual attributes. Personality and audience reaction, the agency added."
            newT.translated = ""
            newT.indexCurrent = 0
            
            let newV = Video.create() as! Video
            newV.name = "video" + String(i)
            newV.translated = ""
            newV.link = "Llw9Q6akRo4"
            newV.timeLoop = 5
            newV.timePlaying = 0
            newV.speed = 1
        }
        
        DB.save()
    }
}
