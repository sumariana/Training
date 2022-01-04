//
//  FavoriteButton.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class FavoriteButton: UIButton {
    var favorited: Bool = false {
        didSet {
            switch favorited {
            case true:
                self.setImage(UIImage(named: "icon_favorited"), for: .normal)
            default:
                self.setImage(UIImage(named: "icon_favorite"), for: .normal)
            }
        }
    }
    
    func isSelected() {
        if favorited {
            favorited = false
        } else {
            favorited = true
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.cornerRadius = 20
        self.layer.backgroundColor = UIColor.ex.blue.cgColor
    }
    
}
