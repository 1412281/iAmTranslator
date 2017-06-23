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
        //if Dictionary.words.count == 0 { readFile() }
    }
    
//    func readFile() {
//        var raws: [String?] = []
//        do {
//            // read file index
//            if let path = Bundle.main.path(forResource: "index", ofType: "txt"){
//                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
//                raws = data.components(separatedBy: "\n")
//                //print(raws)
//            }
//            else {
//                print("file index not found")
//            }
//        } catch let err as NSError {
//            // do something with Error
//            print(err)
//        }
//        
//        for line in raws {
//            if (!(line?.isEmpty)!) {
//                let ar: [String] = (line?.components(separatedBy: "\t"))!
//                Dictionary.words.append(ar[0])
//                Dictionary.offsets.append(Int(ar[1])!)
//                Dictionary.lengths.append(Int(ar[2])!)
//            }
//        }
//        
    
//    }
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

        let mean:String = Dictionary.getMean(word: word)
        
        vc.setWord(word: word, mean: mean)
        navigationController?.pushViewController(vc, animated: true)
    }
}
