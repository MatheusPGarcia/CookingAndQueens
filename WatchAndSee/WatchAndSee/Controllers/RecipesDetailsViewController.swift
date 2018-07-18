//
//  RecipesDetailsViewController.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RecipesDetailsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var durationImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var portionsImage: UIImageView!
    @IBOutlet weak var portionsLabel: UILabel!
    @IBOutlet weak var startRecipeButton: UIButton!

    var databaseConnectivity = ParseManager()

    var recipe: Recipe?
    var recipeImageObj: RecipeImage?
    var sections = ["Ingredientes", "Modo de preparo"]
    var items = [[String]]()
    var steps = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension

        setupDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupDetails() {

        guard let recipe = recipe else { return }
        let reference = recipe.reference

        databaseConnectivity.parseRecipeDetails(predicateName: reference) { (recipeDetails) in

            DispatchQueue.main.async {
                self.durationImage.image = UIImage(named: "Time")
                self.durationLabel.text = recipeDetails.duration

                self.portionsImage.image = UIImage(named: "Portions")
                self.portionsLabel.text = recipeDetails.portions

                self.startRecipeButton.layer.cornerRadius = 5

                self.recipeNameLabel.text = (recipe.name)

                self.items.append(recipeDetails.ingredients)

                self.setupSteps()
            }
        }
    }

    func setupSteps() {

        guard let recipe = recipe else { return }
        let reference = recipe.reference

        databaseConnectivity.parseStep(predicateName: reference) { (stepsArray) in

            for step in stepsArray {
                let text = step.text
                self.steps.append(text)
            }

            self.items.append(self.steps)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.setupImage()
        }
    }

    func setupImage() {

        guard let recipe = recipe else { return }
        let reference = recipe.reference

        databaseConnectivity.parseImage(predicateName: reference) { (imageObj) in
            self.recipeImageObj = imageObj
            self.recipeImage.image = imageObj.image
        }
    }

    @IBAction func startRecipeButtonPressed(_ sender: Any) {

        let watchController = WatchController()

        if let recipe = recipe {

//            if watchController.prepareToSendValue(recipe: recipe) {
//
//                let alertController = UIAlertController(title: "Sucesso",
//                                                        message: "Verifique seu Apple Watch",
//                                                        preferredStyle: .alert)
//
//                let actionOk = UIAlertAction(title: "OK",
//                                            style: .default,
//                                            handler: nil)
//
//                alertController.addAction(actionOk)
//
//                self.present(alertController, animated: true, completion: nil)
//
//            } else {
//
//                let alertController = UIAlertController(title: "Erro",
//                                                        message: "",
//                                                        preferredStyle: .alert)
//
//                let actionOk = UIAlertAction(title: "OK",
//                                             style: .default,
//                                             handler: nil)
//
//                alertController.addAction(actionOk)
//
//                self.present(alertController, animated: true, completion: nil)
//            }
        }
    }
}

extension RecipesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.items.count > 0 {
            return self.items[section].count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsCell") as? RecipeDetailsCell {
            cell.isUserInteractionEnabled = false
            cell.ingredientLabel.text = self.items[indexPath.section][indexPath.row]
            cell.indexLabel.text = String(indexPath.row + 1)
            return cell
        }
        return RecipeDetailsCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "LouisGeorgeCafe", size: 20)
        titleLabel.text = self.sections[section]
        titleLabel.frame = CGRect(x: 20, y: 10, width: view.bounds.width, height: 30)
        headerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        headerView.addSubview(titleLabel)
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
}
