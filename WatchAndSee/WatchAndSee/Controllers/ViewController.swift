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

    var databaseManager: DatabaseService!
    var indicator = 0
    var doneLoading = false
    var recipes = [Recipes]()
    var recipesNames = ["Berinjela à parmegiana", "Bolo Simples", "Costela de cordeiro assada ao molho de hortelã", "Ratatouille"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        setupHighlightRecipe()

        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        databaseManager.createRecipeObject(recipeName: recipesNames, completion: { receivedRecipe in
            self.indicator += 1
            if let recipe = receivedRecipe {
                self.recipes.append(recipe)
                print("\n\n ------ ")
                print(self.recipes)
            }
            if self.indicator == self.recipesNames.count {
                self.view.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.loadingView.isHidden = true
                self.doneLoading = true
            }
        })
    }

    func setupHighlightRecipe() {
        highlightImage.layer.cornerRadius = 5
        highlightImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        highlightImage.image = UIImage(named: "Ratatouille")
        hightlightLabel.text = "Ratatouille"
    }
}

// swiftlint:disable force_cast
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "LouisGeorgeCafe", size: 16)
        titleLabel.text = "Section \(section)"
        titleLabel.frame = CGRect(x: 8, y: 0, width: view.bounds.width, height: 30)
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
