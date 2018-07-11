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
    var categories = [Category]()
    var rec: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        if InternetConnection.checkCconnection() {
            databaseManager.createRecipeObject(completion: { receivedCategories in

                //finished retrieving data from database
                if receivedCategories?.count != 0 {
                    self.categories = receivedCategories!
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.loadingView.isHidden = true
                    self.loadingLabel.isHidden = true
                    self.tableView.reloadData()
                    self.setupHighlightRecipe()
                } else {
                    self.activityIndicator.stopAnimating()
                    self.loadingLabel.text = "Estamos com problemas técnicos. Por favor, tente novamente mais tarde."
                    self.loadingLabel.textColor = UIColor.red
                    return
                }
            })
        } else {
            activityIndicator.stopAnimating()
            self.loadingView.alpha = 0.99
            self.loadingLabel.text = "Sem conexão de Internet"
            self.loadingLabel.textColor = UIColor.red
        }

    }

    @IBAction func highlightPressed(_ sender: Any) {
        goToDetails(recipe: highlightRecipe)
    }

    /// Set up highlight category
    func setupHighlightRecipe() {
        self.highlightRecipe = self.categories[self.categories.count-1].recipes[0]
        highlightImage.image = ObjectsManager.shared.setImage(url: highlightRecipe.photo)
        hightlightLabel.text = highlightRecipe.name

        highlightImage.layer.cornerRadius = 5
        highlightImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }


    /// Perform segue to RecipeDetails
    /// - Parameter recipe: recipe to be displayed
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {

            cell.setup(category: self.categories[indexPath.section])
            cell.delegate = self

            return cell
        }
        return CategoryCell()
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
        return categories.count - 1
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
