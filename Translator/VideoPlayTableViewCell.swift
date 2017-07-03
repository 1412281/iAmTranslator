//
//  VideoPlayTableViewCell.swift
//  Translator
//
//  Created by LamTran on 6/18/17.
//  Copyright © 2017 LamTran. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class VideoPlayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
    }

}
