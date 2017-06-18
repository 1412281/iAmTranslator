//
//  LoginViewController.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBAction func createAccount(_ sender: Any) {
        
        let storyboard=UIStoryboard(name:"Play", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        self.present(vc, animated: true, completion: nil)
        
    }
   
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
               
        // Do any additional setup after loading the view.
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
