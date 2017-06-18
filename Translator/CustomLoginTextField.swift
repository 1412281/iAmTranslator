//
//  CustomLoginTextField.swift
//  Translator
//
//  Created by Tran Hoang Lam on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

@IBDesignable
class CustomLoginTextField: UITextField {
    @IBInspectable var leftImage:UIImage?{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x:5,y:0,width:20,height:20))
            imageView.image=image
            let view = UIView(frame: CGRect(x:0,y:0,width:25,height:20))
            view.addSubview(imageView)
            leftView = view
        }
        else {
            leftViewMode = .never
        }
    }
}
