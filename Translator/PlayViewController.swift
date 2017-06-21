//
//  PlayViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: *** Data model

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
    @IBOutlet weak var audioButton: UIButton!
    
    // MARK: *** UI events
    @IBAction func addButton(_ sender: Any) {
        self.selectAddView.isHidden = false
        view.bringSubview(toFront: backgroundView)
        view.bringSubview(toFront: selectAddView)
        backgroundView.alpha = 0.85
        
    }
    
    @IBAction func allButton(_ sender: Any) {
        currentChoice = Type.recent
        reloadTable()
    }
    @IBAction func textButton(_ sender: Any) {
        currentChoice = Type.text
        reloadTable()
    }
    
    @IBAction func videoButton(_ sender: Any) {
        currentChoice = Type.video
        reloadTable()
    }
    
    
        // MARK: *** UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectAddView.isHidden = true
        
        let touchToHiddenSelectAdd = UITapGestureRecognizer(target: self, action: #selector(PlayViewController.hiddenAdd))
        self.backgroundView.addGestureRecognizer(touchToHiddenSelectAdd)
        
        
        

    }
    
    func hiddenAdd() {
        self.selectAddView.isHidden = true
        view.bringSubview(toFront: menuButton)
        view.bringSubview(toFront: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButton()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        switch currentChoice {
        case .video:
            cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayCell") as! VideoPlayTableViewCell
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: "TextPlayCell") as! TextPlayTableViewCell
        default:
// Temp recently is text
            cell = tableView.dequeueReusableCell(withIdentifier: "TextPlayCell") as! TextPlayTableViewCell
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChoice {
        case .text, .recent:
            let storyB = UIStoryboard(name: "Text", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "TextView") as! TextViewController
            navigationController?.pushViewController(vc, animated: true)
        case .video:
            let storyB = UIStoryboard(name: "Video", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "VideoView") as! VideoViewController
            navigationController?.pushViewController(vc, animated: true)

       
        }
    }
    
    
    //MARK: *** Help function
    func changeButton(){
        textButton.backgroundColor = nil
        videoButton.backgroundColor = nil
        allButton.backgroundColor = nil
        switch currentChoice {
        case .video:
            videoButton.backgroundColor = UIColor.green
      
        case .text:
            textButton.backgroundColor = UIColor.green
        default:
                allButton.backgroundColor = UIColor.green
        }
    }

    func reloadTable() {
        changeButton()
        tableView.reloadData()
    }
}
