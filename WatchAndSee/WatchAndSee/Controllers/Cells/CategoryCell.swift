//
//  CategoryCell.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 23/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    // swiftlint:disable force_cast

    @IBOutlet weak var collectionView: UICollectionView!

    var category: Category?
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("INDEX PATH PRESSED AT \(indexPath)IN COLLECTION\n\n")
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.frame.height)
    }
}
