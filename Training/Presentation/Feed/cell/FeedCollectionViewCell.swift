//
//  FeedCollectionViewCell.swift
//  Training
//
//  Created by TimedoorMSI on 08/12/21.
//

import UIKit
import ImageLoader

class FeedCollectionViewCell: UICollectionViewCell,NibReusable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var nickname: UITextView!
    func buildView(data: FeedItem) {
        var url = ""
        if data.imageUrl != nil {
            url = data.imageUrl!
        }else{
            url = "https://via.placeholder.com/300x300.png?text=Empty+Image"
        }
        imageView.loadProfileImage(url)
        nickname.text = data.nickname
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
