//
//  LoginViewController.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: CustomLoginTextField!
    @IBOutlet weak var pass: CustomLoginTextField!
    @IBOutlet weak var error: UILabel!
    
    @IBAction func login(_ sender: Any) {
        LogIn()
    }
    @IBAction func createAccount(_ sender: Any) {
        
        let storyboard=UIStoryboard(name:"Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        self.present(vc, animated: true, completion: nil)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden=true
        
               
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LogIn(){
        if (pass.text?.characters.count)! < 7 {
            error.isHidden=false;
            self.error.text="Password must be greater than 6 characters"
            return
        }
        else{
            error.isHidden=true;
        }

        Auth.auth().signIn(withEmail: email.text!, password: pass.text!, completion: {
            user,error in
            if(error != nil){
                self.error.isHidden=false;
                self.error.text="Input email was wrong"
                return
            }
            else{
                let storyboard=UIStoryboard(name:"Play", bundle: nil)
                let vc=storyboard.instantiateViewController(withIdentifier: "playNavi") as UIViewController
                self.present(vc, animated: true, completion: nil)
                return
            }
        })
        //error.isHidden=false;
       // self.error.text="Email's format was wrong"

    }

}
