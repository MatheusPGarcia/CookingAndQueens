//
//  CategoryCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 23/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol RecipeDelegate: class {
    func presentData(recipe: Recipes)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var category: Category?
    var objManager = ObjectsManager()
    weak var delegate: RecipeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()    }

    func setup(category: Category) {
        self.category = category
        self.collectionView.reloadData()
    }
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (self.category?.recipes.count)!
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell",
                                                         for: indexPath) as? RecipeCell {
            cell.recipeLabel.text = category?.recipes[indexPath.row].name
            cell.recipeImage.image = objManager.setImage(url: (category?.recipes[indexPath.row].photo)!)
            return cell
        }

        return RecipeCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.presentData(recipe: (self.category?.recipes[indexPath.row])!)
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.frame.height)
    }
}
