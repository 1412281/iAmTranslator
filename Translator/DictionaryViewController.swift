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
    let dict: [String?] = ["hello", "code", "debug"]
    let mean: [String?] = ["xin chào", "tạo hành", "ăn hành"]
    // MARK: *** UI Elements
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
