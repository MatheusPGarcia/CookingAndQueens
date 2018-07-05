//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Firebase

enum DatabaseKeys: Int {
    case categories = 0
    case recipes = 1
}

//Classe Singleton que será responsável pela movimentação no banco de dados
class DatabaseService: NSObject {

    static var shared = DatabaseService()
    let parseRef = ParseManager()
    var ref: DatabaseReference!

    var categories = [Category]()

    private override init() {
        super.init()

        // reference to Firebase Database
        ref = Database.database().reference()
    }

    //retrieve Data from database
//    func createRecipeObject(completion: @escaping (_ response: [Recipes]?) -> Void) {
//        var ingredients = [Recipes]()
//
//        ref.children("Receitas").observeSingleEvent(of: .value) { snapshot in
//            for children in snapshot.children.allObjects {
//                if let childSnapshot = children as? DataSnapshot,
//                    let recipeJSON = childSnapshot.value as? [String: Any] {
//                    let recipe = self.parseRef.parseRecipe(recipeJSON)
//                    print(recipe)
//                    ingredients.append(recipe)
//                }
//
//            }
//            // guarantees it returns a value when it finishes retriving all data
//            completion(ingredients)
//        }
//
//    }
    func createRecipeObject(completion: @escaping (_ response: [Recipes]?) -> Void) {
        var ingredients = [Recipes]()

        ref.observeSingleEvent(of: .value) { snapshot in
            let childSnapshot = snapshot.childSnapshot(forPath: "Categorias")
            for child in childSnapshot.children {

                if let childSnapshot = child as? DataSnapshot,
                    let categoryJSON = childSnapshot.value as? [String: Any] {
                    let category = self.parseRef.parseCategory(categoryJSON)
                }
            }


//            if let childSnapshot = snapshot.children.allObjects[DatabaseKeys.categories.rawValue] as? DataSnapshot,
//                let categoryChild = childSnapshot.children.allObjects as? [Any], let categoryJSON = categoryChild.value as? [String: Any] {
//
//                self.categories = self.parseRef.parseCategories(categoryJSON)
//            }
//
//            if let childSnapshot = snapshot.children.allObjects[DatabaseKeys.recipes.rawValue] as? DataSnapshot,
//                let recipesJSON = childSnapshot.value as? [String: Any] {
//                ingredients = self.parseRef.parseRecipes(recipesJSON)
//            }
//            // guarantees it returns a value when it finishes retriving all data
            completion(ingredients)
        }

    }
}
