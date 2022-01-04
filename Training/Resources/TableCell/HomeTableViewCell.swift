//
//  HomeTableViewCell.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: HomeTableViewCell, section: Int)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var _imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerSelected)))
        // Initialization code
    }
    
    @objc func headerSelected(gestureRecognizer: UITapGestureRecognizer) {
//        let cell = gestureRecognizer.view as! HomeTableViewCell
//        delegate?.toggleSection(header: self, section: cell.section)
    }
}

extension HomeTableViewCell: NibLoadable & Reusable {
    
}
