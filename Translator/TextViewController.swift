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
    var obj: Text?
    
// MARK: *** UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var transText: UITextView!
    @IBOutlet weak var textDict: UITextView!
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    
// MARK: *** UI events
    @IBAction func skipTop(_ sender: Any) {
        saveCurrentTrans(index: indexView)
        initCurrentSentence(index: 0)
    }
    
    @IBAction func back(_ sender: Any) {
        
        saveCurrentTrans(index: indexView)
        
        if indexView > 0 {
            indexView -= 1
        }
        
        initCurrentSentence(index: indexView)
        
    }
    
    @IBAction func current(_ sender: Any) {
        initCurrentSentence(index: Int(obj!.indexCurrent))
    }
    
    @IBAction func next(_ sender: Any) {
        
        saveCurrentTrans(index: indexView)
        
        if indexView < listSentences.count - 2 {
            indexView += 1
        }
        
        initCurrentSentence(index: indexView)

    }
    
// MARK: *** Local variables
    var indexView: Int = 0
    var listSentences = [String]()
    var aSentence = [String]()
    var listTrans = [String]()
    
    
// MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        let back = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backNavi))
        navigationItem.leftBarButtonItem = back
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setLayoutCollectionView()
        
        loadText()
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapCurrent(sender: )))
        currentButton.addGestureRecognizer(longTap)
        
        initCurrentSentence(index: Int(obj!.indexCurrent))
        currentButton.titleLabel?.text = String(Int(obj!.indexCurrent) + 1)
    }
    
    func backNavi() {
        saveCurrentTrans(index: indexView)
        var tempText: String = ""
        for i in 0..<listTrans.count - 1
        {
            tempText +=  listTrans[i] + "."
        }
        print(tempText)
        obj?.translated? = tempText
        
    
        DB.save()
        navigationController?.popViewController(animated: true)
        
    }
    
    
//MARK: *** Process functions
    func loadText() {
        listSentences = (obj!.text?.components(separatedBy: "."))!
        if obj!.translated != "" {
            listTrans = (obj!.translated?.components(separatedBy: "."))!
        }
        else {
            for _ in 0..<listSentences.count {
                listTrans.append("")
            }
        }

    }
    func longTapCurrent(sender: Any?) {
        obj!.indexCurrent = Int32(indexView)
        currentButton.titleLabel?.text = String(Int(obj!.indexCurrent) + 1)
    }
    
    
    func initCurrentSentence(index: Int) {
        transText.text.removeAll()
        transText.text = listTrans[index]
        
        checkRead(index: index)
        
        currentButton.titleLabel?.text = String(Int(obj!.indexCurrent) + 1)
        count.text = String(index + 1) + "/" + String(listSentences.count - 1)
        aSentence = listSentences[index].components(separatedBy: " ")
        
        collectionView.reloadData()
        
        
    }
    
    func saveCurrentTrans(index: Int) {
        if let currentText = transText.text {
            listTrans[index] = currentText
        }
    }
    
    func checkRead(index: Int) {
        if index == 0 {
            backButton.isEnabled = false
            skipButton.isEnabled = false
        }
        else {
            backButton.isEnabled = true
            skipButton.isEnabled = true
        }
        
        if index == listSentences.count - 2 {
            nextButton.isEnabled = false
        }
        else {
            
            nextButton.isEnabled = true
        }

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
        let word = aSentence[indexPath.row].replacingOccurrences(of: ",", with: "").lowercased()
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




