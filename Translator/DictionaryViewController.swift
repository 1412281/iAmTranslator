//
//  DictionaryViewController.swift
//  Translator
//
//  Created by LamTran on 5/31/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: *** Data model
    
    // MARK: *** UI Elements
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        readFile()
    }
    
    func readFile() {
        var raws: [String?] = []
        do {
            // read file index
            if let path = Bundle.main.path(forResource: "testFile", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                raws = data.components(separatedBy: "\n")
                print(raws)
            }
            else {
                print("file index not found")
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        
        for line in raws {
            if (!(line?.isEmpty)!) {
                let ar: [String] = (line?.components(separatedBy: "\t"))!
                Dictionary.words.append(ar[0])
                Dictionary.offsets.append(Decode.from(st: ar[1]))
                Dictionary.lengths.append(Decode.from(st: ar[2]))
            }
        }
//        for i in 0..<Dictionary.words.count {
//            print(Dictionary.words[i] + String(Dictionary.offsets[i]) + String(Dictionary.lengths[i]))
//        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dictionary.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictCell") as! DictionaryTableViewCell
        cell.word.text = Dictionary.words[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyB = UIStoryboard(name: "Dictionary", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "wordDictVC") as! WordDictViewController
        let word = Dictionary.words[indexPath.row]
//        let offset = Dictionary.offsets[indexPath.row]
//        let lengt = Dictionary.lengths[indexPath.row]
//        
//        let start = Dictionary.dict?.index(Dictionary.dict, offsetBy: Dictionary.)
////        let mean = Dictionary.dict[Dictionary.offsets[indexPath.row]..< 1]
        
        let dict = Dictionary.dict
        var mean:String? = ""
        if dict == nil {
            print("File open failed")
        } else {
            dict?.seek(toFileOffset: UInt64(Dictionary.offsets[indexPath.row]))
            let data = dict?.readData(ofLength: Dictionary.lengths[indexPath.row])
            if let dat = data {
                if let me = String(data: dat, encoding: String.Encoding.utf8) as String! {
                    mean = me
                }
            }
                
//            dict?.closeFile()
        }
        vc.setWord(word: word, mean: mean!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
