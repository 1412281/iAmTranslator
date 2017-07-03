//
//  SettingViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "isLogin")

        if FBSDKAccessToken.current() != nil {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        
        try! Auth.auth().signOut()
        
        let storyboard=UIStoryboard(name:"Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
        
        self.present(vc, animated: true, completion: nil)        
    }
    
    
    @IBAction func syncToFirebase(_ sender: Any) {
        
        
        
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
