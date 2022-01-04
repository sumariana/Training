//
//  MenuButton.swift
//  Training
//
//  Created by Sumariana on 05/11/21.
//

import UIKit

class MenuButton: UIButton {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect){
            super.init(frame: frame)
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    @IBInspectable var title : String?{
        didSet{
            self.setTitle(title?.localized, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    private func setup(){
        let icon = UIImage(systemName: "chevron.right")
        tintColor = .black
        setImage(icon, for: .normal)
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .left
//
//        let availableSpace = bounds.inset(by: contentEdgeInsets)
//        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
//        titleEdgeInsets = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 0)
        
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -340).isActive = true
        self.clipsToBounds = true
        self.layer.borderColor = ColorCode.gray.cgColor
        self.layer.borderWidth = CGFloat(1)
        self.setTitleColor(UIColor.black,for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 46,left: 0,bottom: 46,right: 0)
       
    }

}
