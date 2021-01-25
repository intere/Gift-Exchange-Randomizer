//
//  UITableViewCellExtensions.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 1/24/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

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
