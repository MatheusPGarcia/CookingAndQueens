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

    var objManager = ObjectsManager()
    var recipe: Recipes?
    var sections = ["Ingredientes", "Modo de preparo"]
    var items = [[String]]()
    var steps = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension

        setupSteps()

        durationImage.image = UIImage(named: "Time")
        durationLabel.text = recipe?.time

        portionsImage.image = UIImage(named: "Portions")
        portionsLabel.text = recipe?.rendiment

        startRecipeButton.layer.cornerRadius = 5

        recipeImage.image = objManager.setImage(url: (recipe?.photo)!)
        recipeNameLabel.text = (recipe?.name)!

        items.append((recipe?.ingredients)!)
        items.append(self.steps)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupSteps() {
        for element in (recipe?.steps)! {
            self.steps.append(element.text)
        }
    }

    @IBAction func startRecipeButtonPressed(_ sender: Any) {

        let watchController = WatchController()

        if let recipe = recipe {

            if watchController.prepareToSendValue(recipe: recipe) {
                self.alertManager(title: "Sucesso", message: "Verifique seu Apple Watch", status: "OK")
            } else {
                  self.alertManager(title: "Erro", message: "Nenhum Apple Watch pareado", status: "OK")
            }
        }
    }
    func alertManager(title: String, message: String, status: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let actionOk = UIAlertAction(title: status,
                                     style: .default,
                                     handler: nil)

        alertController.addAction(actionOk)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension RecipesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
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
