//
//  TextViewController.swift
//  Translator
//
//  Created by LamTran on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: *** Data model
    var originText: [String] = ["test", "origin", "text", "to", "translate", "origin", "text", "to", "translate", "origin", "text", "to", "translate"]
    // MARK: *** UI Elements
    
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        
        setLayoutCollectionView()
        
    
    }
    
    //MARK: *** ColectionView
    
    func setLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 2
        collectionView.collectionViewLayout = layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! WordCollectionViewCell
        let word = originText[indexPath.row]
        cell.word.text = word
        let length = word.lengthOfBytes(using: String.Encoding.ascii)
        
        cell.word.frame.size.width = CGFloat(8 * length)
        cell.word.frame.size.height = 13
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(originText[indexPath.row].lengthOfBytes(using: String.Encoding.ascii) * 8), height: 13);
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = originText[indexPath.row]
        print(word)
        
        textDict.text = word + "\n" + Dictionary.getMean(word: word)
        dismissKeyboard()

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: *** Keyboard show
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - 40)

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




