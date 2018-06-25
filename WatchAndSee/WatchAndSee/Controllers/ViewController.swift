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


    var databaseManager: DatabaseService!
    var recipies = [[Recipes]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        highlightImage.layer.cornerRadius = 5
        highlightImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false

        databaseManager.createRecipeObject(recipeName: "Bolo Simples", completion: { receivedRecipe in

            if let recipe = receivedRecipe {
                print(recipe)
            }
            self.view.isUserInteractionEnabled = true
        })
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Title \(section)"

    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let titleLabel = UILabel()
//        titleLabel.backgroundColor = .white
//        titleLabel.textColor = .black
//        titleLabel.textAlignment = .left
//        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        titleLabel.frame = CGRect(x: 10, y: -15, width: view.bounds.width, height: 70)
//        titleLabel.text = "Header"
//        headerView.addSubview(titleLabel)
//        return headerView
//    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
