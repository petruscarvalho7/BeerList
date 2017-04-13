//
//  BeerTableViewCell.swift
//  Cervas
//
//  Created by Petrus Carvalho on 12/04/17.
//  Copyright © 2017 Petrus Carvalho. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var cervaImage: UIImageView!
    @IBOutlet weak var cervaName: UILabel!
    @IBOutlet weak var cervaDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
