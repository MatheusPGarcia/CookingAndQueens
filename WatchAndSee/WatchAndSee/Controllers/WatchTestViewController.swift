////
////  WatchTestViewController.swift
////  WatchAndSee
////
////  Created by Matheus Garcia on 25/06/18.
////  Copyright © 2018 Matheus Garcia. All rights reserved.
////
//
//import UIKit
//import WatchConnectivity
//
//class WatchTestViewController: UIViewController, WCSessionDelegate {
//
//    @available(iOS 9.3, *)
//    public func sessionDidDeactivate(_ session: WCSession) {
//    }
//
//    @available(iOS 9.3, *)
//    public func sessionDidBecomeInactive(_ session: WCSession) {
//    }
//
//    @available(iOS 9.3, *)
//    public func session(_ session: WCSession,
//                        activationDidCompleteWith activationState: WCSessionActivationState,
//                        error: Error?) {
//    }
//
//    var value = 0
//    var session: WCSession!
//
//    var databaseManager: DatabaseService!
//    var recipies = Recipes()
//
//    @IBOutlet weak var valueLabel: UILabel!
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        if WCSession.isSupported() {
//            session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        databaseManager = DatabaseService.shared
//
//        self.view.isUserInteractionEnabled = false
//
//        databaseManager.createRecipeObject(recipeName: "Bolo Simples", completion: { receivedRecipe in
//
//            if let recipe = receivedRecipe {
//                print(recipe)
//
//                self.recipies = recipe
//            }
//
//            self.view.isUserInteractionEnabled = true
//        })
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    fileprivate func updateLabel (value: Int) {
//        valueLabel.text = "\(value)"
//    }
//
//    internal func session(_ session: WCSession,
//                          didReceiveApplicationContext applicationContext: [String: Any]) {
//
//        let sessionValue = applicationContext["Value"] as? Int
//
//        DispatchQueue.main.async {
//
//            guard let safeValue = sessionValue else { return }
//
//            self.value = safeValue
//            self.updateLabel(value: self.value)
//        }
//    }
//
//    func sendValue(data: [String: Any?]) {
//
//        do {
//            let valueToSend = data
//            try session.updateApplicationContext(valueToSend)
//            print("Sucesso")
//        } catch {
//            let alertController = UIAlertController(title: "Erro",
//                                                    message: "Não rolou por: \(error)",
//                                                    preferredStyle: .alert)
//
//            let actionOk = UIAlertAction(title: "OK",
//                                         style: .default,
//                                         handler: nil)
//
//            alertController.addAction(actionOk)
//
//            self.present(alertController, animated: true, completion: nil)
//            print("error")
//        }
//    }
//
//    @IBAction func subWasPressed(_ sender: UIButton) {
//
//        value -= 1
//        updateLabel(value: value)
//    }
//
//    @IBAction func addWasPressed(_ sender: UIButton) {
//
//        value += 1
//        updateLabel(value: value)
//    }
//
//    @IBAction func sendToWatchWasPressed(_ sender: UIButton) {
//        let parse = ParseWatch()
//        let steps = parse.sendToWatch(recipe: recipies)
//        sendValue(data: steps)
//    }
//}
