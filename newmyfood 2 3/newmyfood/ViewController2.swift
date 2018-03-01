//
//  ViewController2.swift
//  newmyfood
//
//  Created by jamel on 09/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
 var  SingelItem:FoodItem?
    override func viewDidLoad() {
        super.viewDidLoad()

        laPdt.text = SingelItem?.NameProduit!
        laCat.text = SingelItem?.CategorieProduit!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var laPdt: UILabel!
    
    @IBOutlet weak var laCat: UILabel!
 
}
