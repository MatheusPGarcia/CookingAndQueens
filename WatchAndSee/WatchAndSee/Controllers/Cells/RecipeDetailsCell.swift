//
//  RecipeDetailsCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 27/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RecipeDetailsCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
