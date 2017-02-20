//
//  customCell.swift
//  clothingApplication
//
//  Created by User on 2017/02/11.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class customCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myImageView2: UIImageView!
    
    @IBOutlet weak var myImageView3: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}

