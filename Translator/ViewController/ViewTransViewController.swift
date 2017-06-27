//
//  ViewTransViewController.swift
//  Translator
//
//  Created by LamTran on 6/27/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class ViewTransViewController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var text: UITextView!
    
    var w: String?
    var m: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        name.text = w
        text.text = m
    }
    
    func setView(name: String, text: String) {
        w = name
        m = text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
