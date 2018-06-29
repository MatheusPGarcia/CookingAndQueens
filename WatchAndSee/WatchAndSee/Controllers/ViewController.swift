//
//  ViewController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var hightlightLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var highlightButton: UIButton!

    var databaseManager: DatabaseService!
    var objManager = ObjectsManager()

    var highlightRecipe: Recipes!
    var recipes = [Recipes]()
    var categories = [Category]()
    var rec: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        setupCategories(name: "Para impressionar as visitas",
                        elements: ["Costela de cordeiro assada ao molho de hortelã", "Ratatouille"])
        setupCategories(name: "Almoço requintado",
                        elements: ["Sanduíche de Carne de Panela na Travessa", "Berinjela à parmegiana", "Rabada"])

        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        databaseManager.createRecipeObject(completion: { receivedRecipe in

            //finished retrieving data from database
            if receivedRecipe != nil {
                self.recipes = receivedRecipe!
                self.view.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.loadingView.isHidden = true
                self.loadingLabel.isHidden = true
                self.categories = self.objManager.createCategories(self.recipes, self.categories)
                self.tableView.reloadData()
                self.setupHighlightRecipe()
            }
        })
    }

    @IBAction func highlightPressed(_ sender: Any) {
        goToDetails(recipe: highlightRecipe)
    }

    func setupHighlightRecipe() {

        let search = "Torta de Frango"
        let result = recipes.filter({ (rec) -> Bool in
            rec.name.lowercased().contains(search.lowercased())
        })
        highlightImage.layer.cornerRadius = 5
        highlightImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        highlightImage.image = setImage(url: result[0].photo)
        hightlightLabel.text = result[0].name
        highlightRecipe = result[0]
    }

    func setImage(url: String) -> UIImage {
        var data: Data
        // swiftlint:disable force_try

        let imgURL = URL(string: url)
        data = try! Data(contentsOf: imgURL!)
        let image = UIImage(data: data)
        return image!
    }

    func setupCategories(name: String, elements: [String]) {
        var category = Category()

        category.setValues(name, elements)
        categories.append(category)
    }

    func goToDetails(recipe: Recipes) {
        self.rec = recipe
        performSegue(withIdentifier: "recipeDetails", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipesDetailsViewController {
            recipeDetailsVC.recipe = self.rec!
        }
    }
}

// swiftlint:disable force_cast
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell

        cell.setup(category: self.categories[indexPath.section])
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "LouisGeorgeCafe", size: 16)
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

    func presentData(recipe: Recipes) {
        goToDetails(recipe: recipe)
    }

}
