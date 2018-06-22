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
    var recipies = [[Recipes]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseManager = DatabaseService.shared

        self.view.isUserInteractionEnabled = false

        databaseManager.createRecipeObject(recipeName: "Bolo Simples", completion: { receivedRecipe in

            if let recipe = receivedRecipe {
                print(recipe)
            }
            self.view.isUserInteractionEnabled = true
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
