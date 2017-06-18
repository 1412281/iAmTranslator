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

    
    enum type {
        case Text
        case Video
        case Audio
    }
    var currentChoice = type.Text
      // MARK: *** UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    // MARK: *** UI events
    
    @IBAction func textButton(_ sender: Any) {
        currentChoice = type.Text
        reloadTable()
    }
    
    @IBAction func videoButton(_ sender: Any) {
        currentChoice = type.Video
        reloadTable()
    }
    
    @IBAction func audioButton(_ sender: Any) {
        currentChoice = type.Audio
        reloadTable()
    }
    
    
        // MARK: *** UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
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
            
        case .Video:
            cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayCell") as! VideoPlayTableViewCell
        case .Audio:
            cell = tableView.dequeueReusableCell(withIdentifier: "AudioPlayCell") as! AudioPlayTableViewCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "TextPlayCell") as! TextPlayTableViewCell
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChoice {
        case .Text:
            let storyB = UIStoryboard(name: "Text", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "TextView") as! TextViewController
            navigationController?.pushViewController(vc, animated: true)
        case .Video:
            let storyB = UIStoryboard(name: "Video", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "VideoView") as! VideoViewController
            navigationController?.pushViewController(vc, animated: true)

        case .Audio:
            let storyB = UIStoryboard(name: "Audio", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "AudioView") as! AudioViewController
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    //MARK: *** Help function
    func changeButton(){
        textButton.backgroundColor = nil
        videoButton.backgroundColor = nil
        audioButton.backgroundColor = nil
        switch currentChoice {
        case .Video:
            videoButton.backgroundColor = UIColor.black
        case .Audio:
            audioButton.backgroundColor = UIColor.black
        default:
            textButton.backgroundColor = UIColor.black
            
        }
    }

    func reloadTable() {
        changeButton()
        tableView.reloadData()
    }
}
