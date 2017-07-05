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
        let link = "/" + resultLink[0] + "/text/" + data.date.toString()
        
        ref.child(link+"/date").setValue(data.date.toString())
        ref.child(link+"/name").setValue(data.name)
        ref.child(link+"/text").setValue(data.text)
        ref.child(link+"/translated").setValue(data.translated)
        ref.child(link+"/indexCurrent").setValue(data.indexCurrent)
    }   
    


    func saveButton(sender: UIBarButtonItem) {
        if (nameText.text == "" || textOrigin.text == "") {
            return
        }
        
        let newText = Text.create() as! Text
        newText.date = NSDate()
        //print(newText.date.toString())
        newText.name = nameText.text?.replacingOccurrences(of: "\n", with: "")
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

extension NSDate
{
    func toString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self as Date)
    }
    
}

extension String
{
    func toDate() -> NSDate
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: self) as! NSDate
    }
}
