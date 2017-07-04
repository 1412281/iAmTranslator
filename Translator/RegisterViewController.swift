//
//  RegisterViewController.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var email: CustomLoginTextField!
    
    @IBOutlet weak var pass: CustomLoginTextField!
    @IBOutlet weak var repass: CustomLoginTextField!
    @IBOutlet weak var error: UILabel!
    
    @IBAction func registerButton(_ sender: Any) {
        Register()
    }
    
    @IBAction func backRegister(_ sender: Any) {
        
        let storyboard=UIStoryboard(name:"Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        error.isHidden=true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Register(){
        if (pass.text?.characters.count)! < 7 {
            error.isHidden=false;
            self.error.text="Password must be greater than 6"
            return
        }
        else {
            error.isHidden=true;
        }
        
        if pass.text != repass.text {
            error.isHidden=false;
            self.error.text="Repassword was wrong"
            return
        }
        else{
            error.isHidden=true;
        }
        
        Auth.auth().createUser(withEmail: self.email.text!, password: self.pass.text!, completion: {
            user,error in
            if(error != nil){
                self.error.isHidden=false;
                self.error.text="Email's format was wrong or email existed"
            }else{
                Auth.auth().signIn(withEmail: self.email.text!, password: self.pass.text!, completion: {
                    user, error in
                    if(error != nil){
                        print("error");
                        return
                    }
                    else {
                        nameUser=self.email.text!
                        UserDefaults.standard.setValue(true, forKey: "isLogin")
                        let storyboard=UIStoryboard(name:"Main", bundle: nil)
                        let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
                        
                       self.present(vc, animated: true, completion: nil)
                    return
                    }
                })
            }
        })
        

    }

}
