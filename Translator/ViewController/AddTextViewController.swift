//
//  AddTextViewController.swift
//  Translator
//
//  Created by LamTran on 6/20/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class AddTextViewController: UIViewController {

    // MARK: *** Data model
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textOrigin: UITextView!
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController
    
    // MARK: *** Process functions

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.title = "Add Text"
        // Do any additional setup after loading the view.
    }

    func saveButton(sender: UIBarButtonItem) {
        
        let newText = Text.create() as! Text
        newText.name = nameText.text
        newText.text = textOrigin.text
        
        newText.translated = ""
        newText.indexCurrent = 0
        
        DB.save()
        print("save")
        navigationController?.popViewController(animated: true)
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
