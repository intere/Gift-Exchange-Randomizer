//
//  TextField.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 1/23/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

import UIKit

class TextField: UITextField {
    var padding: UIEdgeInsets

    init(padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 4
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
