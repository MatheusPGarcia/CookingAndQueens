//
//  CategoryCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 23/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol RecipeDelegate {
    func presentData(recipe: Recipes)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var category: Category?
    var delegate: RecipeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()    }

    func setup(category: Category) {
        self.category = category
        self.collectionView.reloadData()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//    }

}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (self.category?.recipes.count)!
    }
    // swiftlint:disable force_cast

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeLabel.text = category?.recipes[indexPath.row].name
        cell.recipeImage.image = setImage(url: (category?.recipes[indexPath.row].photo)!)

        return cell
        // swiftlint:enable force_cast

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("INDEX PATH PRESSED AT \(indexPath)IN COLLECTION\n\n")

        self.delegate?.presentData(recipe: (self.category?.recipes[indexPath.row])!)
    }

    func setImage(url: String) -> UIImage {
        var data: Data
        // swiftlint:disable force_try

        let imgURL = URL(string: url)
        data = try! Data(contentsOf: imgURL!)
        let image = UIImage(data: data)
        return image!
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.frame.height)
    }
}
