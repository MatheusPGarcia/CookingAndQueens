//
//  ViewController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highlightImage: UIImageView!


    var databaseManager: DatabaseService!
    var recipies = [[Recipes]]()

    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
    }

    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
    }

    @available(iOS 9.3, *)
    public func session(_ session: WCSession,
                        activationDidCompleteWith activationState: WCSessionActivationState,
                        error: Error?) {
    }

    var value = 0
    var session: WCSession!

    @IBOutlet weak var valueLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

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

    fileprivate func updateLabel (value: Int) {
        valueLabel.text = "\(value)"
    }

    internal func session(_ session: WCSession,
                          didReceiveApplicationContext applicationContext: [String: Any]) {

        let sessionValue = applicationContext["Value"] as? Int

        DispatchQueue.main.async {

            guard let safeValue = sessionValue else { return }

            self.value = safeValue
            self.updateLabel(value: self.value)
        }
    }

    func sendValue() {

        do {
            let valueToSend = ["Value": value]
            try session.updateApplicationContext(valueToSend)
        } catch {
            print("error")
        }
    }

    @IBAction func subWasPressed(_ sender: UIButton) {

        value -= 1
        updateLabel(value: value)
    }

    @IBAction func addWasPressed(_ sender: UIButton) {

        value += 1
        updateLabel(value: value)
    }

    @IBAction func sendToWatchWasPressed(_ sender: UIButton) {
        sendValue()
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
