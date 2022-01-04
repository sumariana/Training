//
//  HomeViewController.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    var sideMenu: SideMenu!

    fileprivate lazy var dataSource: HomeDataSource = {
        return HomeDataSource(self)
    }()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = dataSource
            //            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeCell")
            tableView.register(cellType: HomeTableViewCell.self)
        }
    }
    
    var listRecipe: [HomeModel] = [] {
        didSet {
            tableView.reloadData()
            for _ in listExpanded.count ..< listRecipe.count {
                listExpanded.append(false)
            }
        }
    }
    
    var listExpanded: [Bool] = []

    var presenter: HomePresenterProtocol!

    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let button = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.rightBarButtonItem = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(self)
        self.presenter.fetchHome()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        createSideMenu()
    }
    
    // Open Popup Right Side
    @objc func openSideMenu() {
        if sideMenu.isHidden {
            sideMenu.isHidden = false
        } else {
            dismissSideMenu()
        }
    }
    
    // Hide Popup Right Side
    @objc func dismissSideMenu() {
        sideMenu.isHidden = true
    }

    
    // MARK: Private Methods
    
    // GEnerate SIde Menu
    private func createSideMenu() {
        sideMenu = SideMenu().loadNib()
        sideMenu.delegate = self

        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sideMenu)
        self.view.addConstraint(NSLayoutConstraint(item: sideMenu, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        sideMenu.isHidden = true
    }
}

// MARK: HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func buildView(list: [HomeModel]) {
        self.listRecipe.append(contentsOf: list)
    }
    
    func buildError(_ error: ErrorModel) {
        //showHTTPError(code: error.code)
    }
    
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissSideMenu()
    }
}


// MARK: SideMenuDelegate

extension HomeViewController: SideMenuDelegate {
    func profileMenu() {
        let profile = ProfileViewController.instantiateStoryboard()
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    func favoriteMenu() {
        print("Skip!")
//        let favorite = FavoriteViewController.instantiateStoryboard()
//        self.navigationController?.pushViewController(favorite, animated: true)
    }
    
    func signOutMenu() {
        User.shared.logout()
        let login = LoginViewController.instantiateStoryboard()
        self.present(login, animated: true)
    }
}
