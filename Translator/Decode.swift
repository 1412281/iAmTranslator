//
//  Decode.swift
//  Translator
//
//  Created by LamTran on 6/21/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class Decode: NSObject {
    let gValue:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    
    
    func from(st: String) -> Int {
       
        var chars = Array(st.characters)
        print(chars)
        
        var decValue:Int = 0
        var charValue: Int?
        let len = chars.count
        let dec = Decimal(64)
        
        for i in 0..<len{
            print(chars[i])
            if let idx = gValue.characters.index(of: chars[i]) {
                charValue = gValue.characters.distance(from: gValue.startIndex, to: idx)
                //print("Found \(chars[i]) at position \(pos)")
                
            }
            
            let re = NSDecimalNumber(decimal: pow(dec, len - i - 1))
            
            decValue += Int(re) * charValue!
        }
        return decValue
    }
}
