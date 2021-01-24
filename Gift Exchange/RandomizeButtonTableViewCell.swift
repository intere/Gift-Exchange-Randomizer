//
//  RandomizeButtonTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

protocol RandomizeCellDelegate: class {
    func tappedRandomize()
}

class RandomizeButtonTableViewCell: UITableViewCell {

    let randomizeButton = UIButton(type: .custom)
    var delegate: RandomizeCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction
    func randomizePressed(_ source: Any) {
        AnalyticsManager.shared.trackTappedRandomized()
        delegate?.tappedRandomize()
    }

}

// MARK: - Implementation

private extension RandomizeButtonTableViewCell {

    func buildView() {
        randomizeButton.setImage(UIImage(named: "RandomizeBtn"), for: .normal)
        randomizeButton.addTarget(self, action: #selector(randomizePressed(_:)), for: .touchUpInside)

        contentView.addSubview(randomizeButton)

        constrain(contentView, randomizeButton) { (view, randomizeButton) in

            randomizeButton.height == 50
            randomizeButton.width == 100

            randomizeButton.top == view.top
            randomizeButton.centerX == view.centerX
            randomizeButton.bottom == view.bottom
        }
    }

}
