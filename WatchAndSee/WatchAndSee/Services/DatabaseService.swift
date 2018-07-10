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
    var objManager = ObjectsManager()
    var ref: DatabaseReference!

    var categories = [Category]()

    private override init() {
        super.init()

        // reference to Firebase Database
        ref = Database.database().reference()
    }

    func createRecipeObject(completion: @escaping (_ response: [Category]?) -> Void) {
        var recipes = [Recipes]()

        ref.observeSingleEvent(of: .value) { snapshot in

//            let categoryJSON = self.retrieveData(dump: Category.self, snapshot: snapshot, path: "Categorias")

            var childSnapshot = snapshot.childSnapshot(forPath: "Categorias")
            for child in childSnapshot.children {

                if let childSnapshot = child as? DataSnapshot,
                    let categoryJSON = childSnapshot.value as? [String: Any] {
                    let category = self.parseRef.parseCategory(categoryJSON)
                    self.categories.append(category)
                }
            }

            childSnapshot = snapshot.childSnapshot(forPath: "Recipes")
            for child in childSnapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let recipeJSON = childSnapshot.value as? [String: Any] {
                    let recipe = self.parseRef.parseRecipe(recipeJSON)
                    recipes.append(recipe)
                }
            }

            self.categories = self.objManager.createCategories(recipes, self.categories)

            completion(self.categories)
        }

    }
//
//    func retrieveData<T>(dump: T.Type, snapshot: DataSnapshot, path: String) -> [T] {
//        var data = [T]()
//        var childSnapshot = snapshot.childSnapshot(forPath: path)
//
//        for child in childSnapshot.children {
//            if let typeJSON = childSnapshot.value as? [String: Any] {
//                let data = self.parseRef.parseData(dump: dump, dataDic: typeJSON)
//                self.categories.append(data)
//            }
//        }
//        return data
//    }
}
