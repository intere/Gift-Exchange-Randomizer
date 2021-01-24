//
//  MainTableViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

class MainTableViewController: UITableViewController {

    let analytics: AnalyticsManaging
    let nameManager: NameManaging
    let matchupManager: MatchupManaging

    override var navigationController: UINavigationController? {
        return super.navigationController ?? parent?.navigationController
    }

    init(analytics: AnalyticsManaging, nameManager: NameManaging, matchupManager: MatchupManaging) {
        self.analytics = analytics
        self.nameManager = nameManager
        self.matchupManager = matchupManager
        super.init(style: .plain)
        tableView.separatorStyle = .none
        view.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NamesCell")
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(EnterNameTableViewCell.self, forCellReuseIdentifier: "AddNameCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonsCell")

        let headerView = UIView()
        let logoView = UIImageView(image: UIImage(named: "GiftExchangeLogo"))
        logoView.contentMode = .scaleAspectFit

        headerView.addSubview(logoView)
        constrain(headerView, logoView) { (view, logoView) in
            logoView.top == view.top + 8
            logoView.left == view.safeAreaLayoutGuide.left + 24
            logoView.bottom == view.bottom - 8
            logoView.right == view.safeAreaLayoutGuide.right - 24
            logoView.height == 140
        }

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 156)

        tableView.tableHeaderView = headerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        analytics.trackScreen(named: "Main")
    }

    // TODO: Keep track of selected cell

}

// MARK: - NameAddedDelegate

extension MainTableViewController: NameAddedDelegate {

    func added(name: String) {
        nameManager.add(name: name)

        if let indexPath = indexPathForName(name: name) {
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }

}

// MARK: - ButtonsCellDelegate

extension MainTableViewController: ButtonsCellDelegate {

    func tappedReset() {
        analytics.trackTappedReset()
        nameManager.clear()
        tableView.reloadData()
    }

    func tappedRandomize() {
        analytics.trackTappedRandomized()
        let names = nameManager.getAllNames()
        AlertHelper.checkRandomizeMatchup(names: names, parentVC: self) { (success: Bool) in
            guard success else {
                return
            }

            let randomizeVC = RandomizeNamesTableViewController.newStyledInstance(
                with: names,
                analyticsManager: analytics,
                matchupManager: matchupManager,
                nameManager: nameManager
            )
            navigationController?.pushViewController(randomizeVC, animated: true)
        }
    }

}

// MARK: - Table view data source

extension MainTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        case 1:
            return 1

        case 2:
            return nameManager.getAllNames().count

        case 3:
            return 1

        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "NamesCell", for: indexPath).namesTextCell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNameCell", for: indexPath).clearBackground
            guard let enterNameCell = cell as? EnterNameTableViewCell else {
                return cell
            }
            enterNameCell.delegate = self
            return enterNameCell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath).clearBackground
            if let nameCell = cell as? NameTableViewCell {
                nameCell.name = nameManager.getAllNames()[indexPath.row]
            }
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsCell", for: indexPath).clearBackground
            guard let buttonsCell = cell as? ButtonTableViewCell else {
                return cell
            }
            buttonsCell.delegate = self
            return buttonsCell

        default:
            return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath).clearBackground
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 2:
            return true
        default:
            return false
        }
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.nameManager.remove(index: indexPath.row)
            tableView.endUpdates()

        }

        return [deleteAction]
    }

}

// MARK: - Navigation

extension MainTableViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let names = nameManager.getAllNames()
        var result = false
        AlertHelper.checkRandomizeMatchup(names: names, parentVC: self) { (success: Bool) in
            result = success
        }
        return result
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showRandomizeTableSegue" {
            analytics.trackTappedRandomized()
        }
    }
}


// MARK: - Helper functions

private extension MainTableViewController {

    func indexPathForName(name: String) -> IndexPath? {
        guard let row = nameManager.row(forName: name) else {
            return nil
        }

        return IndexPath(row: row, section: 2)
    }

}

// MARK - UITableViewCell.clear

extension UITableViewCell {

    /// Clears the background color and returns a reference to self
    var clearBackground: UITableViewCell {
        backgroundColor = .clear
        return self
    }

    var namesTextCell: UITableViewCell {
        guard let imageView = imageView else {
            return clearBackground
        }

        imageView.image = UIImage(named: "EnterYourNames")
        imageView.contentMode = .scaleAspectFit

        constrain(self, imageView) { (view, imageView) in
            imageView.centerX == view.centerX
            imageView.top == view.top
            imageView.bottom == view.bottom
            imageView.width == 250
        }

        return clearBackground
    }
}
