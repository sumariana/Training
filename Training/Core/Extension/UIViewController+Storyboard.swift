//
//  UIViewController+Storyboard.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiateStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    static func instantiateStoryboard(name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    static func instantiateStoryboard(bundle: Bundle?) -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: bundle)
        return storyboard.instantiateInitialViewController()!
    }
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

