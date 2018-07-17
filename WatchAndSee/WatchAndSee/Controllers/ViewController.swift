//
//  ViewController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var hightlightLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var highlightButton: UIButton!

    let databaseConnectivity = ParseManager()

    var highlightRecipe: Recipe!
    var highlightCategory: Category!
    var recipes = [Recipe]()
    var categories = [Category]()
    var rec: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        if InternetConnection.checkCconnection() {

            setupCategories { () in
                DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.loadingView.isHidden = true
                    self.loadingLabel.isHidden = true
                    self.tableView.reloadData()
                    self.setupHighlightRecipe()
                }
            }
        } else {
            activityIndicator.stopAnimating()
            self.loadingView.alpha = 0.99
            self.loadingLabel.text = "Sem conexão de Internet"
        }
    }

    @IBAction func highlightPressed(_ sender: Any) {
        goToDetails(recipe: highlightRecipe)
    }

    func setupHighlightRecipe() {

        highlightImage.layer.cornerRadius = 5
        highlightImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        let reference = highlightCategory.reference

        databaseConnectivity.parseRecipes(predicateName: reference) { (recipes) in
            if let recipe = recipes.first {
                DispatchQueue.main.async {
                    self.hightlightLabel.text = recipe.name
                    self.highlightRecipe = recipe

                    self.setImage(recipe: recipe)
                }
            }
        }
    }

    func setImage(recipe: Recipe) {

        let reference = recipe.reference

        self.databaseConnectivity.parseImage(predicateName: reference) { (image) in
            self.highlightImage.image = image.image
        }
    }

    private func setupCategories(completion: @escaping () -> Void) {

        databaseConnectivity.parseCategories { (categoriesArray) in
            for singleCategory in categoriesArray {
                let name = singleCategory.name
                let reference = singleCategory.reference

                let newCategory = Category(name: name, reference: reference)

                self.categories.append(newCategory)
            }

            let highlightName = "Destaque do dia"

            guard let highlightCategory = self.categories.first(where: {$0.name == highlightName}) else { return }
            self.highlightCategory = highlightCategory

            guard let index = self.categories.index(where: {$0.name == highlightName}) else { return }
            self.categories.remove(at: index)

            completion()
        }
    }

    private func setupRecipies(_ category: Category, completion: @escaping ([Recipe]) -> Void) {

        let categoryReference = category.reference
        databaseConnectivity.parseRecipes(predicateName: categoryReference) { (recipesArray) in

            var recipesObjects = [Recipe]()

            for recipe in recipesArray {
                let name = recipe.name
                let reference = recipe.reference

                let newRecipe = Recipe(name: name, reference: reference)
                recipesObjects.append(newRecipe)
            }

            completion(recipesObjects)
        }
    }

    func goToDetails(recipe: Recipe) {
        self.rec = recipe
        performSegue(withIdentifier: "recipeDetails", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipesDetailsViewController {
            recipeDetailsVC.recipe = self.rec!
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        //swiftlint:enable force_cast

        cell.setup(category: self.categories[indexPath.section])
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "OleoScript-Regular", size: 19)
        titleLabel.text = self.categories[section].name
        titleLabel.frame = CGRect(x: 20, y: 0, width: view.bounds.width, height: 30)
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("INDEX PATH PRESSED AT \(indexPath)IN TABLE\n")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ViewController: RecipeDelegate {

    func presentData(recipe: Recipe) {
        goToDetails(recipe: recipe)
    }

}
