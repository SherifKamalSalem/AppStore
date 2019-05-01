//
//  BackEnabledNavController.swift
//  AppStore
//
//  Created by Xpress Integration on 5/1/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class BackEnabledNavController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
