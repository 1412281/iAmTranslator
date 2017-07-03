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
    
    @IBOutlet weak var tempLabel: UILabel!
    
// MARK: *** UI events
    @IBAction func skipTop(_ sender: Any) {
        saveCurrentTrans(index: indexView)
        indexView = 0
        initCurrentSentence(index: indexView)
    }
    
    @IBAction func back(_ sender: Any) {
        
        saveCurrentTrans(index: indexView)
        
        if indexView > 0 {
            indexView -= 1
        }
        
        initCurrentSentence(index: indexView)
        
    }
    
    @IBAction func current(_ sender: Any) {
        indexView = Int(obj!.indexCurrent)
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
        
        let viewBtn = UIBarButtonItem(title: "View", style: .plain, target: self, action: #selector(viewTrans))
        navigationItem.rightBarButtonItem = viewBtn
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        collectionView.delegate = self
        
        setLayoutCollectionView()
        
        loadText()
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapCurrent(sender: )))
        currentButton.addGestureRecognizer(longTap)
        
        indexView = Int(obj!.indexCurrent)
        
        initCurrentSentence(index: Int(obj!.indexCurrent))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dismissKeyboard()
    }
    func viewTrans() {
        dismissKeyboard()
        saveTrans()
        
        let storyB = UIStoryboard.init(name: "Play", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "ViewTransVC") as! ViewTransViewController
        vc.setView(name: obj!.name!, text: obj!.translated!)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveTrans() {
        saveCurrentTrans(index: indexView)
        var tempText: String = ""
        for i in 0..<listTrans.count - 1
        {
            tempText +=  listTrans[i] + "`"
        }
        print(tempText)
        obj?.translated? = tempText
        
        DB.save()
    }
    
    func backNavi() {
        saveTrans()
        navigationController?.popViewController(animated: true)
        
    }
    
    
//MARK: *** Process functions
    func loadText() {
        listSentences = (obj!.text?.components(separatedBy: "."))!
        if obj!.translated != "" {
            listTrans = (obj!.translated?.components(separatedBy: "`"))!
        }
        else {
            for _ in 0..<listSentences.count {
                listTrans.append("")
            }
        }

    }
    
    func longTapCurrent(sender: Any?) {
        obj!.indexCurrent = Int32(indexView)
        currentButton.setTitle(String(Int(obj!.indexCurrent) + 1), for: UIControlState.normal)
    }
    
    
    func initCurrentSentence(index: Int) {
        
        changeCurrentButtonText(index: index)
        
        collectionView.reloadData()
        
        transText.text.removeAll()
        transText.text = listTrans[index]
        
        checkRead(index: index)
        
        count.text = String(index + 1) + "/" + String(listSentences.count - 1)
        aSentence = listSentences[index].components(separatedBy: " ")
        
        
    }
    
    func changeCurrentButtonText(index: Int) {
        if index != Int(obj!.indexCurrent) {
            currentButton.setTitle(String(Int(obj!.indexCurrent) + 1), for: UIControlState.normal)
        }
        else if index == Int(obj!.indexCurrent){
            currentButton.setTitle("now", for: UIControlState.normal)
        }
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
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 1
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
        cell.word.sizeToFit()
        //cell.word.frame.size.height = 18

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let word = aSentence[indexPath.row]
        
        tempLabel.text = word
        tempLabel.sizeToFit()
                return CGSize(width: tempLabel.frame.width, height: tempLabel.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let word = aSentence[indexPath.row].replacingOccurrences(of: ",", with: "").lowercased()
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
            if mean != "" {
                textDict.text = word.substring(to: word.index(after: idx)) + "\n" + mean
            }
            else {
                textDict.text = word + "\n Not found this word"
            }
        }
       
        dismissKeyboard()

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
//MARK: *** Keyboard show
    let temp:CGFloat = 50
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - temp)
                textDict.frame = CGRect(x: textDict.frame.origin.x, y: textDict.frame.origin.y + keyboardSize.height - temp, width: textDict.frame.width, height: textDict.frame.height - keyboardSize.height + temp)
                //navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
                 textDict.frame = CGRect(x: textDict.frame.origin.x, y: textDict.frame.origin.y - keyboardSize.height + temp, width: textDict.frame.width, height: textDict.frame.height + keyboardSize.height - temp)
                //navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
}




