//
//  MainTabViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 26/10/21.
//

import UIKit

class MainTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tabBarController = TabBarViewController()
        tabBarController.selectedTab = 0
        tabBarController.initTab()
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController = tabBarController
        }, completion: { completed in
            // maybe do something here
        })
        
        //swipeable
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("LEFT")
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            print("RIGHT")
            self.tabBarController!.selectedIndex -= 1
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        parent?.viewWillAppear(animated)
       
    }

    //
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
