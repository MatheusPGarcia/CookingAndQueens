//
//  CategoryCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 23/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol RecipeDelegate: class {
    func presentData(recipe: Recipe)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var category: Category?
    var recipes = [Recipe]()
    var images = [RecipeImage]()

    let databaseConnectivity = ParseManager()

    weak var delegate: RecipeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()    }

    func setup(category: Category) {
        self.category = category

        let reference = category.reference
        databaseConnectivity.parseRecipes(predicateName: reference) { (recipesArray) in
            DispatchQueue.main.async {
                self.recipes = recipesArray

                for recipe in self.recipes {
                    self.setupImage(recipe: recipe)
                }

                self.collectionView.reloadData()
            }
        }

        self.collectionView.reloadData()
    }

    func setupImage(recipe: Recipe) {

        let reference = recipe.reference

        databaseConnectivity.parseImage(predicateName: reference) { (imageObj) in
            DispatchQueue.main.async {
                self.images.append(imageObj)

                self.collectionView.reloadData()
            }
        }
    }
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (self.recipes.count)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell",
                                                         for: indexPath) as? RecipeCell {

            let index = indexPath.row

            cell.recipeLabel.text = recipes[index].name

            let reference = recipes[index].reference

            if let imageToRecipe = self.images.first(where: {$0.reference == reference}) {
                cell.recipeImage.image = imageToRecipe.image
            }

            return cell
        }

        return RecipeCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.presentData(recipe: (self.recipes[indexPath.row]))
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.frame.height)
    }
}
