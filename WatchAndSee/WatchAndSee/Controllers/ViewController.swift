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

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseManager = DatabaseService.shared
        databaseManager.createRecipeObject(recipeName: "Bolo Simples")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
