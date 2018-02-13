//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by ATEmobile on 13/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return(UINavigationController(rootViewController: self))
    }
}
