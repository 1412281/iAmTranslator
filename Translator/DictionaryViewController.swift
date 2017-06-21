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
    var dict: [String?] = []
    var mean: [String?] = []
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
            // This solution assumes  you've got the file in your bundle
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
            let ar: [String?] = (line?.components(separatedBy: "\t"))!
            dict.append(ar[0])
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictCell") as! DictionaryTableViewCell
        cell.word.text = dict[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyB = UIStoryboard(name: "Dictionary", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "wordDictVC") as! WordDictViewController
        vc.setWord(word: dict[indexPath.row]!, mean: mean[indexPath.row]!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
