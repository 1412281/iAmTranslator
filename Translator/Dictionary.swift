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
    static var dict: FileHandle? = FileHandle(forReadingAtPath: Bundle.main.path(forResource: "anhviet109K", ofType: "txt")!)

}
