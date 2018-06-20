//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Firebase

//Classe Singleton que será responsável pela movimentação no banco de dados
class DatabaseService: NSObject {

    static var shared = DatabaseService()
    var ref: DatabaseReference!
    var recipes = Recipes()

    private override init() {
        super.init()
        ref = Database.database().reference()
    }

    func createRecipeObject(recipeName: String) {
        var ingredients: [String]

        ref.child("Recipes").child(recipeName).child("Ingredientes").observeSingleEvent(of: .value) { snapshot in

            guard let ingrDictionary = snapshot.value as? [String: Any] else {
                print("deu merda")
                return
            }

            print(ingrDictionary)
        }

    }
}
