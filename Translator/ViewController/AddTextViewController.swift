//
//  AddTextViewController.swift
//  Translator
//
//  Created by LamTran on 6/20/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class AddTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.title = "Add Text"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButton(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }

    func saveButton(sender: UIBarButtonItem) {
    
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
