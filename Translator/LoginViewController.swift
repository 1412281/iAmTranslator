//
//  LoginViewController.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import FBSDKLoginKit

import Firebase
var nameUser:String?
class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var viewloading: UIView!
    
    @IBOutlet weak var email: CustomLoginTextField!
    @IBOutlet weak var pass: CustomLoginTextField!
    @IBOutlet weak var error: UILabel!
    
    var ref: DatabaseReference!
  
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
        
        ref = Database.database().reference()
        
        
        error.isHidden=true
        navigationController?.setNavigationBarHidden(true, animated: false)
        loginFacebook.delegate=self
        loginFacebook.readPermissions = ["public_profile","email","user_friends"]
         print("--------------------------------Logout");
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        showLoading()
        
        if CheckLogined(){
            return
        }
        else if FBSDKAccessToken.current() != nil{
            
            ReadDataBase()
            
            let storyboard=UIStoryboard(name:"Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            return
        } else {
            viewloading.isHidden = true
        }


    }
    
    func ReadText(){
        var listText = Text.all() as! [Text]
        if listText.count != 0
        {
            return
        }
        let resultLink = nameUser!.components(separatedBy: ["@"])
        let link = resultLink[0] + "/text"
        ref.child(link).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value==nil {
                return
            }
            for (key, value) in value! {
                
                
                let newT = Text.create() as! Text
                
                //print("Property: \"\(value as! NSDictionary)\"")
                var attrText = value as! NSDictionary
                
                newT.name = attrText["name"] as? String
                newT.text=attrText["text"] as! String
                newT.translated=attrText["translated"] as! String
                newT.indexCurrent=attrText["indexCurrent"]  as! Int32
                newT.date =  (attrText["date"] as! String).toDate()

                DB.save()
            }
            
            
            print(value)
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    func ReadVideo(){
       var listVideo = Video.all() as! [Video]
        
        if listVideo.count != 0
        {
            return
        }
        
        let resultLink = nameUser!.components(separatedBy: ["@"])
        let link = resultLink[0] + "/video"
        ref.child(link).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value==nil {
                return
            }
            for (key, value) in value! {
                
                
                let newV = Video.create() as! Video
                
                //print("Property: \"\(value as! NSDictionary)\"")
                var attrVideo = value as! NSDictionary
                newV.name = attrVideo["name"] as? String
                newV.length=attrVideo["length"] as! Double
                newV.link=attrVideo["link"] as! String
                newV.speed=attrVideo["speed"]  as! Int32
                newV.timeLoop=attrVideo["timeLoop"] as! Int32
                newV.timePlaying=attrVideo["timePlaying"] as! Int32
                newV.translated=attrVideo["translated"] as! String
                newV.date =  (attrVideo["date"] as! String).toDate()

                DB.save()
            }
            
            
            print(value)
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func ReadDataBase(){
        ReadText()
        ReadVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CheckLogined() -> Bool{
        var isLogin:Bool = false
        if UserDefaults.standard.object(forKey: "isLogin") != nil && UserDefaults.standard.object(forKey: "user") != nil {
            isLogin  = try UserDefaults.standard.value(forKey: "isLogin")! as! Bool
            nameUser = try UserDefaults.standard.value(forKey: "user")! as! String
        }
        if isLogin {
            
            
            //ReadDataBase()
            
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            let storyboard=UIStoryboard(name:"Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
            
             self.present(vc, animated: true, completion: nil)
            return true
        }
        
        return false
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                self.showLoading()
                let fbDetails = result as! NSDictionary
                nameUser = fbDetails["id"] as! String
                UserDefaults.standard.setValue(nameUser, forKey: "user")
                print(nameUser)
                
                self.ReadDataBase()
                
                let storyboard=UIStoryboard(name:"Main", bundle: nil)
                let vc=storyboard.instantiateViewController(withIdentifier: "tabMain") as UIViewController
                
                self.present(vc, animated: true, completion: nil)

                
                
            }else{
                print(error?.localizedDescription ?? "Not found")
            }
        })
        
        
        
        
        
       
        
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
                
                nameUser=self.email.text!
                
                self.ReadDataBase()
                
                UserDefaults.standard.setValue(nameUser, forKey: "user")
                
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
    
    func showLoading() {
        let gif = UIImage.gifImageWithName("loading")
        let loadImg = UIImageView(image: gif)
        loadImg.layer.cornerRadius = 80
        loadImg.layer.masksToBounds = true
        loadImg.frame = CGRect(x: 50.0, y: 120.0, width: self.view.frame.size.width - 100, height: 200.0)
        viewloading.addSubview(loadImg)
        viewloading.isHidden = false
    }
    
    
}
