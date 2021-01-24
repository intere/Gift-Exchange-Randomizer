//
//  RandomizeNamesTableViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class RandomizeNamesTableViewController: UITableViewController {

    // Ordered list of names
    var names = [String]()

    // Who is assigned to who
    var matchups = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        randomizeMatchup()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(RandomizeButtonTableViewCell.self, forCellReuseIdentifier: "RandomizeCell")
        tableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        AnalyticsManager.shared.trackScreen(named: "Randomize Names")
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }

}

// MARK: - API

extension RandomizeNamesTableViewController {

    static func newStyledInstance(with names: [String]) -> StyledParentViewController {

        let childVC = RandomizeNamesTableViewController()
        childVC.names = names

        return StyledParentViewController.newInstance(withChild: childVC)
    }
}

// MARK: - RandomizeCellDelegate

extension RandomizeNamesTableViewController: RandomizeCellDelegate {

    func tappedRandomize() {
        randomizeMatchup()
    }
}

// MARK: - Table view data source

extension RandomizeNamesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return matchups.keys.count

        case 1:
            return 1

        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath).clearBackground
            let name = names[indexPath.row]

            if let nameCell = cell as? NameTableViewCell, let buyFor = matchups[name] {
                nameCell.name = "\(name) buys a gift for \(buyFor)"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomizeCell", for: indexPath).clearBackground
            guard let randomizeCell = cell as? RandomizeButtonTableViewCell else {
                return cell
            }
            randomizeCell.delegate = self
            return randomizeCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        }
    }

}

// MARK: - Helper functions

private extension RandomizeNamesTableViewController {
    
    func randomizeMatchup() {
        names = NameManager.shared.getAllNames()
        AlertHelper.checkRandomizeMatchup(names: names, parentVC: self) { (success: Bool) in
            guard success else {
                return
            }
            MatchupManager.shared.names = names
            matchups = MatchupManager.shared.randomize()
            tableView.reloadData()
        }
    }
}


