//
//  TabBarViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 26/10/21.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    var selectedTab = 0
    var onTransition: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    func initTab() {
        var bottomTabs: [UIViewController] = []
        let homeController = FeedViewController.instantiateStoryboard()
        homeController.tabBarItem = UITabBarItem(title: "Feed".localized, image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        

        let messageController = MessageViewController.instantiateStoryboard()
        messageController.tabBarItem =  UITabBarItem(title: "Messages".localized, image: UIImage(systemName: "message.fill"), tag: 1)
           
        let myPageController = MyPageViewController.instantiateStoryboard()
        myPageController.tabBarItem = UITabBarItem(title: "My Page".localized, image: UIImage(systemName: "person.fill"), tag: 2)
            
        bottomTabs.append(homeController)
        bottomTabs.append(messageController)
        bottomTabs.append(myPageController)
        
        let controllers = bottomTabs
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            for controller in controllers {
                controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            }
        }
        
        self.tabBar.itemPositioning = .fill
        self.tabBar.itemSpacing = 0.2
        self.tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.tabBar.layer.shadowRadius = 8
        self.tabBar.layer.shadowOpacity = 0.25
        self.tabBar.layer.masksToBounds = false
        self.tabBar.tintColor = UIColor.ex.black
        self.tabBar.barTintColor = UIColor.white

        self.viewControllers = controllers

        self.viewControllers = controllers.map {
            let nav = UINavigationController(rootViewController: $0)
            return nav
        }
        self.selectedIndex = selectedTab
        
        self.delegate = self
    }
    
    override class func awakeFromNib() {
        
    }
}
