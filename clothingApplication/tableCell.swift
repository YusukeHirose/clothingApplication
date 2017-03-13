//
//  tableCell.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class tableCell: UITableViewCell {

    @IBOutlet weak var wantImage: UIImageView!
    
    
    @IBOutlet weak var wantName: UILabel!
    
    @IBOutlet weak var wantBlandName: UILabel!
    
    @IBOutlet weak var wantPrice: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
