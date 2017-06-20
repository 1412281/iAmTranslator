//
//  WordDictViewController.swift
//  Translator
//
//  Created by LamTran on 6/19/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class WordDictViewController: UIViewController {

    
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var mean: UITextView!
    
    var w: String?
    var m: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        word.text = w
        mean.text = m
    }
    func setWord(word: String, mean: String) {
        w = word
        m = mean
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
