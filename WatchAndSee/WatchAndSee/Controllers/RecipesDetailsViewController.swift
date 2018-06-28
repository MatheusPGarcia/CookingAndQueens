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

    var recipe: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        durationImage.image = UIImage(named: "Time")
        durationLabel.text = recipe?.time

        portionsImage.image = UIImage(named: "Portions")
        portionsLabel.text = recipe?.rendiment

        startRecipeButton.layer.cornerRadius = 5

        recipeImage.image = setImage(url: (recipe?.photo)!)
        recipeNameLabel.text = (recipe?.name)!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setImage(url: String) -> UIImage {
        var data: Data
        // swiftlint:disable force_try

        let imgURL = URL(string: url)
        data = try! Data(contentsOf: imgURL!)
        let image = UIImage(data: data)
        return image!
    }

    @IBAction func startRecipeButtonPressed(_ sender: Any) {

        let watchController = WatchController()

        if let recipe = recipe {
            if watchController.prepareToSendValue(recipe: recipe) {

                let alertController = UIAlertController(title: "Sucesso",
                                                        message: "",
                                                        preferredStyle: .alert)

                let actionOk = UIAlertAction(title: "OK",
                                            style: .default,
                                            handler: nil)

                alertController.addAction(actionOk)

                self.present(alertController, animated: true, completion: nil)

            } else {

                let alertController = UIAlertController(title: "Erro",
                                                        message: "",
                                                        preferredStyle: .alert)

                let actionOk = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)

                alertController.addAction(actionOk)

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

// swiftlint:disable force_cast

extension RecipesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsCell") as! RecipeDetailsCell
        cell.ingredientLabel.text = self.recipe?.ingredients[indexPath.section]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.recipe?.ingredients.count)!
    }

}
