//
//  MessageCollectionViewCell.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 14/12/21.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var chatButton: UIButton!{
        didSet{
            chatButton.frame.size.width = CGFloat(0)
            chatButton.frame.size.height = CGFloat(0)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var talkId = 0
    var isItemSelected = false
    
    var addIdFunction : ((Int) -> Void?)? = nil
    var removeIdFunction : ((Int) -> Void?)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func buildView(messageItem: MessageLocalItem?, addSelectedIdFunc: ((Int) -> Void)? = nil, removeSelectedIdFunc: ((Int) -> Void)? = nil) {
        addIdFunction = addSelectedIdFunc
        removeIdFunction = removeSelectedIdFunc
        if messageItem != nil {
//            Nuke.loadImage(with: URL(string: messageItem!.imageUrl), into: imageProfile)
            imageProfile.loadProfileImage(messageItem?.imageUrl ?? "")
            imageProfile.layer.cornerRadius = self.frame.height / 2.8
            nameLabel.text = messageItem!.nickname
            messageLabel.text = messageItem!.message
            talkId = messageItem?.talkId ?? 0
        }
       
    }
    @IBAction func changeFavoriteBtn(_ sender: Any) {
        if !isItemSelected {
            chatButton.setImage(UIImage(named: "icon_radio_picked"), for: .normal)
            removeIdFunction!(talkId)
        }else{
            chatButton.setImage(UIImage(named: "icon_radio"), for: .normal)
            addIdFunction!(talkId)
        }
        isItemSelected = !isItemSelected
    }
    
    func changeMode(isEditMode: Bool) {
        if isEditMode {
            for constraint in chatButton.constraints {
                if constraint.identifier == "radioWidth" {
                   constraint.constant = 30
                }
            }
        }else{
            for constraint in chatButton.constraints {
                if constraint.identifier == "radioWidth" {
                   constraint.constant = 0
                }
            }
            chatButton.setImage(UIImage(named: "icon_radio"), for: .normal)
            isItemSelected = false
        }
    }

}

