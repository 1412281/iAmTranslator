//
//  LoginViewController.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var email: CustomLoginTextField!
    @IBOutlet weak var pass: CustomLoginTextField!
    @IBOutlet weak var error: UILabel!
    
  
    @IBOutlet weak var loginFacebook: FBSDKLoginButton!
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        loginFacebook.delegate=self
        loginFacebook.readPermissions = ["public_profile","email","user_friends"]
         print("--------------------------------Logout");
        
        if CheckLogined(){
            return
        }
        
        if FBSDKAccessToken.current() != nil{
            let storyboard=UIStoryboard(name:"Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CheckLogined() -> Bool{
        var isLogin:Bool = false
        if UserDefaults.standard.object(forKey: "isLogin") != nil {
            isLogin  = try UserDefaults.standard.value(forKey: "isLogin")! as! Bool
        }
        if isLogin {
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            let storyboard=UIStoryboard(name:"Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
             self.present(vc, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
     
        
            print("000000000000000000000000000000")
            
            let storyboard=UIStoryboard(name:"Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
           self.present(vc, animated: true, completion: nil)
            
        
        
       
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("--------------------------------Logout");
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
                UserDefaults.standard.setValue(true, forKey: "isLogin")

                let storyboard=UIStoryboard(name:"Main", bundle: nil)
                let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
                self.present(vc, animated: true, completion: nil)
                return
            }
        })
        //error.isHidden=false;
       // self.error.text="Email's format was wrong"

    }
    
    
    
}
