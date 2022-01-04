//
//  UISubtitleLabel.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import UIKit

class UISubtitleLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        setup()
    }
    
    override init(frame: CGRect){
        super.init(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        
        setup()
//        super.init(frame:  CGRect(x: 0, y: 18, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(){
        print("SETUP CALLED")
        textColor = UIColor.black
        font = UIFont.systemFont(ofSize: 12)
        
    }
    
    func setTitle(title: String){
        self.text = title
        sizeToFit()
    }

}
