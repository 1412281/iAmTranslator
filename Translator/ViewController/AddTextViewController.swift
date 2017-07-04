//
//  AddTextViewController.swift
//  Translator
//
//  Created by LamTran on 6/20/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Firebase
class AddTextViewController: UIViewController {
 var ref: DatabaseReference!
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
    
    func AddDatabase(data:Text){
        ref = Database.database().reference()
        
        print(nameUser)
        let resultLink = nameUser!.components(separatedBy: ["@"])
        let link = "/" + resultLink[0] + "/text/text1"
        
        ref.child(link+"/name").setValue(data.name)
        ref.child(link+"/text").setValue(data.text)
        ref.child(link+"/translated").setValue(data.translated)
        ref.child(link+"/indexCurrent").setValue(data.indexCurrent)
    }
    


    func saveButton(sender: UIBarButtonItem) {
        
        let newText = Text.create() as! Text
        newText.name = nameText.text
        newText.text = textOrigin.text
        
        newText.translated = ""
        newText.indexCurrent = 0
        
        DB.save()
        AddDatabase( data: newText)
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
