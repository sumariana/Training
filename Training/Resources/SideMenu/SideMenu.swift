//
//  SideMenu.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit

class SideMenu: UIView {
    
    var delegate: SideMenuDelegate!
    
    @IBOutlet weak var profileButton: UILabel! {
        didSet {
            profileButton.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(openProfile))
            profileButton.addGestureRecognizer(tap)
        } }
    
    @IBOutlet weak var favoriteButton: UILabel! {
        didSet {
            favoriteButton.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(openFavorite))
            favoriteButton.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var signOutButton: UILabel! {
        didSet {
            signOutButton.isUserInteractionEnabled = true
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(signOut))
            signOutButton.addGestureRecognizer(tap3)
        }
    }
    
    @objc func openProfile() {
        self.delegate.profileMenu()
    }
    
    @objc func openFavorite() {
        self.delegate.favoriteMenu()
    }
    
    @objc func signOut() {
        self.delegate.signOutMenu()
    }
}

protocol SideMenuDelegate {
    func profileMenu()
    func favoriteMenu()
    func signOutMenu()
}
