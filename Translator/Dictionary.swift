//
//  Dictionary.swift
//  Translator
//
//  Created by LamTran on 6/21/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import Foundation

class Dictionary {
    static var words: [String] = []
    static var offsets: [Int] = []
    static var lengths: [Int] = []
    static var file: FileHandle? = FileHandle(forReadingAtPath: Bundle.main.path(forResource: "anhviet109K", ofType: "txt")!)

    init() {
        
        var raws: [String?] = []
        do {
            // read file index
            if let path = Bundle.main.path(forResource: "index", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                raws = data.components(separatedBy: "\n")
                //print(raws)
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
                Dictionary.offsets.append(Int(ar[1])!)
                Dictionary.lengths.append(Int(ar[2])!)
            }
        }
        

    }
    
    static func getMean(word: String) -> String {
        if let dict = file {
            if let idx = Dictionary.words.index(of: word) {
                dict.seek(toFileOffset: UInt64(offsets[idx]))
                let data = dict.readData(ofLength: lengths[idx])
                
                    if let mean = String(data: data, encoding: String.Encoding.utf8) as String! {
                        return mean
                    }
                
            }
        }
        return "Not found this word"
    }
}
