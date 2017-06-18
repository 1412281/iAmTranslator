//
//  PlayViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: *** Local variables

    var currentChoice = type.Text
    enum type {
        case Text
        case Video
        case Audio
    }

    // MARK: *** Data model
       // MARK: *** UI Elements
    
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    // MARK: *** UI events
    
    @IBAction func textButton(_ sender: Any) {
        currentChoice = type.Text
    }
    
    @IBAction func videoButton(_ sender: Any) {
        currentChoice = type.Video
    }
    
    @IBAction func audioButton(_ sender: Any) {
        currentChoice = type.Audio
    }
    
    func changeButton(button: String){
        textButton.backgroundColor = nil
        videoButton.backgroundColor = nil
        audioButton.backgroundColor = nil
        switch button {
        case "video":
            videoButton.backgroundColor = UIColor.black
        case "audio":
            audioButton.backgroundColor = UIColor.black
        default:
            textButton.backgroundColor = UIColor.black

        }
    }
    
        // MARK: *** UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayCell")
        case .Audio:
            cell =.
        default:
            <#code#>
        }
        
        return cell
    }
}
