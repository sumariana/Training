//
//  HomeDataSource.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import Kingfisher

class HomeDataSource: NSObject {
    
    // MARK: Initialize
    
    var view: HomeViewController!
    
    init(_ view: HomeViewController) {
        self.view = view
    }
}

extension HomeDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.listRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let item = view.listRecipe[indexPath.row]
        let url = URL(string: item.imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        cell._imageView.kf.setImage(with: url)
        return cell
    }
}
