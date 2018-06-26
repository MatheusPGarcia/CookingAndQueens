//
//  RecipeCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 23/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
//    @IBOutlet weak var recipeButton: UIButton!

    @IBOutlet weak var recipeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.cornerRadius = 5
        recipeImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
