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
    var originText: String = ""
    var translated: String = ""
    var currentTran: Int = 0
    var indexView: Int = 0
    
    // MARK: *** UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tranText: UITextView!
    @IBOutlet weak var textDict: UITextView!
    @IBOutlet weak var workView: UIView!
    // MARK: *** UI events
    
    @IBAction func skipTop(_ sender: Any) {
    }
    
    @IBAction func back(_ sender: Any) {
    }
    
    @IBAction func playing(_ sender: Any) {
    }
    
    @IBAction func next(_ sender: Any) {
        currentTran += 1
        initCurrentSentence()
    }
    
    // MARK: *** Local variables
    
    var listSentences = [String]()
    var aSentence = [String]()
    
    var listTrans = [String]()
    // MARK: *** UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setLayoutCollectionView()
        
        listSentences = originText.components(separatedBy: ".")
        for _ in 0..<listSentences.count {
            listTrans.append("")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initCurrentSentence()
    }
    
    func initCurrentSentence() {
        aSentence = listSentences[currentTran].components(separatedBy: " ")
        collectionView.reloadData()
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
        return aSentence.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! WordCollectionViewCell
        let word = aSentence[indexPath.row]
        cell.word.text = word
        let length = word.characters.count
        
        cell.word.frame.size.width = CGFloat(10 * length)
        cell.word.frame.size.height = 16
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(aSentence[indexPath.row].characters.count * 10), height: 16);
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var word = aSentence[indexPath.row].replacingOccurrences(of: ",", with: "").lowercased()
        var mean = Dictionary.getMean(word: word)
        if mean != "" {
            textDict.text = word + "\n" + mean
        }
        else {
            var idx = word.endIndex
            while (mean == "" && idx > word.startIndex)  {
                let tempWord = word.substring(to: idx)
                mean = Dictionary.getMean(word: tempWord)
                idx = word.index(before: idx)
            }
        }
        if mean != "" {
            textDict.text = word + "\n" + mean
        }
        else {
            textDict.text = word + "\n Not found this word"
        }
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




