//
//  PlayViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import CoreData
import youtube_ios_player_helper

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: *** Data model
    var listText = [Text]()
    var listVideo = [Video]()
    // MARK: *** Local variables
    
    enum `Type` {
        case text
        case video
    }
    var currentChoice = Type.text
   

      // MARK: *** UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var menuButton: UIView!
    @IBOutlet weak var selectAddView: UIView!
    
    @IBOutlet weak var addText: UIButton!
    @IBOutlet weak var addVideo: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    // MARK: *** UI events
    @IBAction func addButton(_ sender: Any) {
        self.selectAddView.isHidden = false
        let touchToHiddenSelectAdd = UITapGestureRecognizer(target: self, action: #selector(PlayViewController.hiddenAdd))
        self.selectAddView.addGestureRecognizer(touchToHiddenSelectAdd)
        view.bringSubview(toFront: addText)
        view.bringSubview(toFront: addVideo)
        
    }
    
    @IBAction func textButton(_ sender: Any) {
        currentChoice = Type.text
        reloadView()
    }
    
    @IBAction func videoButton(_ sender: Any) {
        currentChoice = Type.video
        reloadView()
    }
    
    @IBAction func addText(_ sender: Any) {
        let storyB = UIStoryboard.init(name: "Add", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "AddTextVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addVideo(_ sender: Any) {
        let storyB = UIStoryboard.init(name: "Add", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "AddVideoVC")
        navigationController?.pushViewController(vc, animated: true)

    }
    
        // MARK: *** UIViewController

    override func viewDidLoad() {
        Dictionary.init()
        super.viewDidLoad()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showEditting(_:)))
        longPress.minimumPressDuration = 0.5
        tableView.addGestureRecognizer(longPress)
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEditting(_:)))
        navigationItem.rightBarButtonItem = doneBtn
        
        Text.deleteAllRecords()
        Video.deleteAllRecords()

        initData()
        
    }
    
    func doneEditting(_: Any?) {
        self.tableView.setEditing(false, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showEditting(_: Any?){
        self.tableView.setEditing(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hiddenAdd() {
        self.selectAddView.isHidden = true
        //view.bringSubview(toFront: menuButton)
        //view.bringSubview(toFront: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectAddView.isHidden = true

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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentChoice {
        case .text:
            return 100
        default:
            return 100
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
    
            let url = URL(string: "https://img.youtube.com/vi/" + listVideo[indexPath.row].link! + "/mqdefault.jpg")
            if let data = try? Data(contentsOf: url!) {
                cell.img.image = UIImage(data: data)
            }
            
            cell.length.text = "15:10"
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChoice {
        case .text:
            let storyB = UIStoryboard(name: "Text", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "TextView") as! TextViewController
            
            vc.obj = listText[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        case .video:
            let storyB = UIStoryboard(name: "Video", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "VideoView") as! VideoViewController
            
            let videoObj = listVideo[indexPath.row]
            vc.obj = videoObj
            
            navigationController?.pushViewController(vc, animated: true)

       
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch currentChoice {
            case .text:
                Text.delete(obj: listText[indexPath.row])
                listText = Text.all() as! [Text]
            default:
                Video.delete(obj: listVideo[indexPath.row])
                listVideo = Video.all() as! [Video]
            }
            self.tableView.reloadData()
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
