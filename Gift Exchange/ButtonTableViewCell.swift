//
//  ButtonTableViewCell.swift
//  Gift Exchange
//
//  Created by Greg Willis on 11/2/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

protocol ButtonsCellDelegate: class {
    func tappedReset()
    func tappedRandomize()
}

class ButtonTableViewCell: UITableViewCell {

    let randomizeButton = UIButton(type: .custom)
    let resetButton = UIButton(type: .custom)

    var delegate: ButtonsCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction
    func resetButtonPressed() {
        AnalyticsManager.shared.trackTappedReset()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetAction"), object: nil)
    }  
    
}

// MARK: - Implementation

private extension ButtonTableViewCell {

    func buildView() {
        randomizeButton.setImage(UIImage(named: "RandomizeBtn"), for: .normal)
        resetButton.setImage(UIImage(named: "ResetBtn"), for: .normal)
        [randomizeButton, resetButton].forEach { button in
            contentView.addSubview(button)
            button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        }

        constrain(contentView, randomizeButton, resetButton) { (view, randomizeButton, resetButton) in
            randomizeButton.height == 50
            randomizeButton.width == 100
            randomizeButton.top == view.top
            randomizeButton.right == view.centerX - 20
            randomizeButton.left >= view.left + 40
            randomizeButton.bottom == view.bottom

            resetButton.height == 50
            resetButton.width == 100
            resetButton.top == view.top
            resetButton.left == view.centerX + 20
            resetButton.right <= view.right - 40
            resetButton.bottom == view.bottom
        }
    }

}
