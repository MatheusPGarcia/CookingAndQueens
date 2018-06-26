//
//  ViewController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var databaseManager: DatabaseService!

    var objManager = ObjectsManager()
    var indicator = 0
    var recipes = [Recipes]()

    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        setupHighlightRecipe()
        setupCategories(name: "Para impressionar as visitas", elements: ["Costela de cordeiro assada ao molho de hortelã", "Ratatouille"])
        setupCategories(name: "Almoço requintado", elements: ["Bolo Simples", "Costela de cordeiro assada ao molho de hortelã", "Ratatouille"])

        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        print("Saemi")

        databaseManager.createRecipeObject(completion: { receivedRecipe in
            print("Larissa")
            self.indicator += 1
            if let received = receivedRecipe {
                self.recipes = receivedRecipe!
                self.view.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.loadingView.isHidden = true
                self.categories = self.objManager.createRecipes(self.recipes, self.categories)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCategories(name: String, elements: [String]) {
        var category = Category()

        category.setValues(name, elements)
        categories.append(category)
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
        return categories.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
