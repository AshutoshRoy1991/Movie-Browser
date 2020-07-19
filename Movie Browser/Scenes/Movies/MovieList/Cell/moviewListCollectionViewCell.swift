//
//  moviewListCollectionViewCell.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 17/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class moviewListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        title.numberOfLines = 0
    }
    
}
