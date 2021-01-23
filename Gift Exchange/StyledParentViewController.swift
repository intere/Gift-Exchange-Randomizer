//
//  StyledParentViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 1/3/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

import Cartography
import UIKit

class StyledParentViewController: UIViewController {

    let statusBarView: UIImageView
    let backgroundView: UIImageView
    let childViewController: UIViewController

    override var prefersStatusBarHidden: Bool { false }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }

    init(childViewController: UIViewController, image: UIImage?, statusBarImage: UIImage? = nil) {
        self.childViewController = childViewController
        backgroundView = UIImageView(image: image)
        statusBarView = UIImageView(image: statusBarImage)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        statusBarView.contentMode = .bottom

        [backgroundView, statusBarView, childViewController.view].forEach { view.addSubview($0) }

        constrain(view, backgroundView, statusBarView, childViewController.view) { (parent, background, statusBarView, child) in
            background.top == parent.top
            background.left == parent.left
            background.right == parent.right
            background.bottom == parent.bottom

            statusBarView.top == parent.top
            statusBarView.left == parent.left
            statusBarView.right == parent.right
            statusBarView.height == 20

            child.top == parent.safeAreaLayoutGuide.top
            child.bottom == parent.safeAreaLayoutGuide.bottom
            child.left == parent.safeAreaLayoutGuide.left
            child.right == parent.safeAreaLayoutGuide.right
        }

        childViewController.didMove(toParent: self)
    }
}
