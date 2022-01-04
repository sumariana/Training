//
//  UITitleLabel.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import UIKit

class UITitleLabel: UILabel {

//    override func draw(_ rect: CGRect) {
//        CGRect(x: 0, y: -2, width: 0, height: 0)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect){
        super.init(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(){
        textColor = UIColor.black
        font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func setTitle(title: String){
        text = title
        sizeToFit()
    }

}
