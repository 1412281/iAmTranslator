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
    var words: [String] = []
    var offsets: [Int] = []
    var lengths: [Int] = []
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
                print("file not found")
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        
        for line in raws {
            if (!(line?.isEmpty)!) {
                let ar: [String] = (line?.components(separatedBy: "\t"))!
                words.append(ar[0])
                offsets.append(Decode.from(st: ar[1]))
                lengths.append(Decode.from(st: ar[2]))
            }
        }
        for i in 0..<words.count {
            print(words[i] + String(offsets[i]) + String(lengths[i]))
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictCell") as! DictionaryTableViewCell
        cell.word.text = words[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyB = UIStoryboard(name: "Dictionary", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "wordDictVC") as! WordDictViewController
        vc.setWord(word: words[indexPath.row], mean: words[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
