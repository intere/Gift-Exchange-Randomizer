//
//  NameTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

class NameTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Implementation

private extension NameTableViewCell {

    func buildCell() {
        contentView.addSubview(nameLabel)

        constrain(contentView, nameLabel) { (view, nameLabel) in
            nameLabel.left == view.left + 16
            nameLabel.right == view.right - 16
            nameLabel.top == view.top + 8
            nameLabel.bottom == view.bottom - 8
        }
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor(rgb: 0xe12628)
        nameLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
    }

}
