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

    var recipe: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        durationImage.image = UIImage(named: "Time")
        durationLabel.text = recipe?.time

        portionsImage.image = UIImage(named: "Portions")
        portionsLabel.text = recipe?.rendiment

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
