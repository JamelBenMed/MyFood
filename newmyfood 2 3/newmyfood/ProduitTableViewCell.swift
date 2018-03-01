//
//  ProduitTableViewCell.swift
//  newmyfood
//
//  Created by jamel on 09/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit


class ProduitTableViewCell: UITableViewCell {
    var cellExists:Bool = false


    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = background_color

        // Initialdzation code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    let background_color = UIColor.init(red: 50/255, green: 54/255, blue: 64/255, alpha: 1)

    @IBOutlet weak var laPrdouit: UILabel!
    
    @IBOutlet weak var laCategorie: UILabel!
   

}
