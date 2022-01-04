//
//  ImageCollectionViewCell.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 03/01/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var _imageView: UIImageView!
    var _index = 0
    var openCamera: (() -> Void?)? = nil
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func buildView(data:UIImage, index:Int) {
        _imageView.image = data
    }
    
    func showIcon() {
        _imageView.layer.borderWidth = 2
        _imageView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func hideIcon() {
        _imageView.layer.borderWidth = 0
        _imageView.layer.borderColor = UIColor.orange.cgColor
    }

}
