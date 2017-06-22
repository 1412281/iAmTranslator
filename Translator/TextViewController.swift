//
//  TextViewController.swift
//  Translator
//
//  Created by LamTran on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    // MARK: *** Data model
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var tranText: UITextView!
    
    @IBOutlet weak var textDict: UITextView!
    
    @IBOutlet weak var workView: UIView!
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        textDict.autoresizingMask = [.flexibleHeight]
        
  }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tranText.becomeFirstResponder()
        
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - 40)
//                self.workView
                textDict.frame = CGRect(x: textDict.frame.origin.x, y: textDict.frame.origin.y + keyboardSize.height - 40, width: textDict.frame.width, height: textDict.frame.height - keyboardSize.height + 40)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += (keyboardSize.height - 40)
                 textDict.frame = CGRect(x: textDict.frame.origin.x, y: textDict.frame.origin.y - keyboardSize.height + 40, width: textDict.frame.width, height: textDict.frame.height + keyboardSize.height - 40)
            }
        }
    }
}
