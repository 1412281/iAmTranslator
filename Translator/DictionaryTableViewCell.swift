//
//  DictionaryTableViewCell.swift
//  Translator
//
//  Created by LamTran on 6/17/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit

class DictionaryTableViewCell: UITableViewCell {

    @IBOutlet weak var word: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
