//
//  Common.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CommonTextField: SkyFloatingLabelTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = self.font?.withSize(17)
        
        self.selectedTitleColor = UIColor.gray
        self.lineHeight = 1
        self.selectedLineHeight = 1
        self.tintColor = UIColor.red
    }
    
    @IBInspectable var baseName: String = "" {
        didSet {
            self.title = NSLocalizedString(baseName, comment: "")
            self.placeholder = NSLocalizedString(baseName, comment: "")
        }
    }
    
    @IBInspectable var basePlaceholder: String = "" {
        didSet {
            self.placeholder = NSLocalizedString(basePlaceholder, comment: "")
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        setTitleVisible(true, animated: true, animationCompletion: nil)
        placeholder = ""
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        setTitleVisible(false, animated: true, animationCompletion: nil)
        placeholder = basePlaceholder
        super.resignFirstResponder()
        return true
        
    }
}
