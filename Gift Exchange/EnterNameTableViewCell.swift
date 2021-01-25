//
//  EnterNameTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

protocol NameAddedDelegate: class {

    func added(name: String)
}

// MARK: - EnterNameTableViewCell

class EnterNameTableViewCell: UITableViewCell {
    private var nameText = TextField()
    weak var delegate: NameAddedDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate

extension EnterNameTableViewCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard string.isNewLine else {
            return true
        }

        textField.resignFirstResponder()
        notifyNewName(name: textField.text)
        textField.text = nil
        return false
    }
}

// MARK: - Implementation

private extension EnterNameTableViewCell {

    func buildCell() {
        nameText.delegate = self
        nameText.placeholder = "Enter a name"
        nameText.autocapitalizationType = .words
        nameText.autocorrectionType = .no
        nameText.spellCheckingType = .no
        nameText.alpha = 0.5
        nameText.backgroundColor = .white

        contentView.addSubview(nameText)
        constrain(contentView, nameText) { (view, nameText) in
            nameText.top == view.top + 8
            nameText.left == view.left + 40
            nameText.right == view.right - 40
            nameText.bottom == view.bottom - 8
        }
    }

    func notifyNewName(name: String?) {
        guard let name = name else {
            return
        }

        delegate?.added(name: name)
    }

}

// MARK: - String.isNewline

extension String {
    var isNewLine: Bool {
        return self == "\n"
    }
}
