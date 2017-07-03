//
//  TextViewController.swift
//  Translator
//
//  Created by LamTran on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class TextReadViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: *** Data model
    var obj: Text?
    
    // MARK: *** UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var textDict: UITextView!
    
    // MARK: *** UI events
    // MARK: *** Local variables
    var readText = [String]()
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        collectionView.delegate = self
        
        setLayoutCollectionView()
        loadText()
        
    }
    
    func loadText() {
        readText = (obj?.text?.components(separatedBy: " "))!
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
        return readText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordReadCell", for: indexPath) as! WordReadCollectionViewCell
        let word = readText[indexPath.row]
        cell.word.text = word
        cell.word.sizeToFit()
        //cell.word.frame.size.height = 18
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let word = readText[indexPath.row]
        
        tempLabel.text = word
        tempLabel.sizeToFit()
                return CGSize(width: tempLabel.frame.width, height: tempLabel.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = readText[indexPath.row].replacingOccurrences(of: ",", with: "").lowercased()
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
        
        
    }
    
   
}




