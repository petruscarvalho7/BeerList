//
//  BeerDetailsViewController.swift
//  Cervas
//
//  Created by Petrus Carvalho on 12/04/17.
//  Copyright © 2017 Petrus Carvalho. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {

    @IBOutlet weak var cervaImage: UIImageView!
    @IBOutlet weak var cervaName: UILabel!
    @IBOutlet weak var cervaTagDesc: UILabel!
    @IBOutlet weak var cervaDesc: UILabel!
   
    var beer: BeerModel = BeerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cervaDesc.text = beer.cervaDesc
        cervaName.text = beer.cervaName
        cervaTagDesc.text = beer.cervaTagDesc
        cervaImage.image = beer.cervaImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
