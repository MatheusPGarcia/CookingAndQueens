//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Firebase

class DatabaseService: NSObject {

    static var shared = DatabaseService()
    var objManager = ObjectsManager()
    var ref: DatabaseReference!
    var recipeRef: Recipes?

    var categories = [Category]()

    private override init() {
        super.init()

        // reference to Firebase Database
        ref = Database.database().reference()
    }

    /// Responsible for estabilishing connection with Firebase and for data retrieving.
    /// - Parameter completion: indicates to ViewController the data retrieving is over
    /// - Return: array of categories that will compose the main screen

    func createRecipeObject(completion: @escaping (_ response: [Category]?) -> Void) {
        var recipes = [Recipes]()

        ref.observeSingleEvent(of: .value) { snapshot in

            let categoriesBase = self.retrieveData(object: CategoryParser(), snapshot: snapshot, path: "Categorias")
            let recipes = self.retrieveData(object: RecipeParser(), snapshot: snapshot, path: "Recipes")
            self.categories = self.objManager.createCategories(recipes, categoriesBase)

            completion(self.categories)
        }

    }

    func retrieveData<T: PersistenceObject>(object: T, snapshot: DataSnapshot, path: String) -> [T.InternalType] {
        var dataArray = [T.InternalType]()

        let childSnapshot = snapshot.childSnapshot(forPath: path)

        for child in childSnapshot.children {
            if  let childSnapshot = child as? DataSnapshot,
                let typeJSON = childSnapshot.value as? [String: Any] {
                let data = object.parseData(dataDic: typeJSON)
                dataArray.append(data)
            }
        }
        return dataArray
    }
}
