//
//  ReadViewController.swift
//  Translator
//
//  Created by LamTran on 7/3/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

        // MARK: *** Data model
    var listText = [Text]()
    
    // MARK: *** UI Elements
    @IBOutlet weak var tableView: UITableView!

    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController
    
    // MARK: *** Process functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func doneEditting(_: Any?) {
        self.tableView.setEditing(false, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showEditting(_: Any?){
        self.tableView.setEditing(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        listText = Text.all() as! [Text]
        
        tableView.reloadData()
        
    }

//MARK: *** Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listText.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextReadCell") as! ReadTableViewCell
        cell.name.text = listText[indexPath.row].name
        cell.des.text = listText[indexPath.row].text
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let storyB = UIStoryboard(name: "Read", bundle: nil)
            let vc = storyB.instantiateViewController(withIdentifier: "TextReadViewVC") as! TextReadViewController
            
            vc.obj = listText[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
     
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Text.delete(obj: listText[indexPath.row])
            listText = Text.all() as! [Text]
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        self.tableView.reloadData()

    }
    

}
