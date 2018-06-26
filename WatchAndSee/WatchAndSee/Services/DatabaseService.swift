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
    let parseRef = ParseManager()
    var ref: DatabaseReference!
//    var recipes = Recipes()

    private override init() {
        super.init()
        ref = Database.database().reference()
    }

    func createRecipeObject(recipeName: [String], completion: @escaping (_ response: Recipes?) -> Void) {

        for element in recipeName {
            ref.child("Recipes").child(element).observeSingleEvent(of: .value) { snapshot in
                guard let snapshotDic = snapshot.value as? [String: Any] else {
                    print("deu merda")
                    completion(nil)
                    return
                }
                let recipe = self.parseRef.parseRecipe(snapshotDic)

                completion(recipe)
            }
        }
    }

}
