//
//  TalkTableViewCell.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import UIKit

class TalkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet var chatContainer: UIView!
    @IBOutlet var bubble: UIImageView!
    @IBOutlet weak var tvTime: UILabel!
    @IBOutlet weak var tvMessage: UILabel!
    var profileImage: String = ""
    var item: TalkItems?{
        didSet{
            tvTime.text = UTCToLocal(date: item!.time ?? "", format: "HH:mm")
            if(item?.messageKind == 1){
                ivProfile.layer.masksToBounds = true
                ivProfile.layer.cornerRadius = ivProfile.bounds.width / 2
                ivProfile.loadProfileImage(profileImage)
                bubble.tintColor = UIColor.ex.gray
                let leftImage = UIImage(named: "bubble_left")
                bubble.image = leftImage!.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 10), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
            }else{
                bubble.tintColor = UIColor.ex.blue
                let img = UIImage(named: "bubble_right")
                bubble.image = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
            }
            
            switch item?.mediaType{
                case 0:
                    tvMessage.isHidden = false
                    tvMessage.text = String(item!.message!)
                    break
                case 1:
                    if let imgUrl = item?.mediaUrl {
                        if let imgSize = item?.mediaSize {
                             addPicture(imgUrl, imgSize)
                        }
                    }
                    break
                case 2:
                    addVideoImage()
                    break
                default:
                    break
            }
        }
    }
    var picture: UIImageView!
    var videoPicture: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        chatContainer.backgroundColor = UIColor.white.withAlphaComponent(0)
        tvMessage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        //Reset view for reuse
        tvMessage.isHidden = true
        if chatContainer.subviews.count > 1 {
            if let pict = picture {
                pict.removeFromSuperview()
            }
            if let video = videoPicture {
                video.removeFromSuperview()
            }
        }
        self.layoutIfNeeded()
    }
    
    func addPicture(_ imgUrl: String, _ imgSize: String) {
        let imgWidth = NumberFormatter().number(from: (imgSize.getFirstCharacterDivideBy("x"))) as! CGFloat
        let imgHeight = NumberFormatter().number(from: (imgSize.getLastCharacterDivideBy("x"))) as! CGFloat
       
        let scaleFactor = (UIScreen.main.bounds.width / 2) / imgWidth
        
        var newHeight = imgHeight * scaleFactor
        var newWidth = imgWidth * scaleFactor
        
        if imgWidth > imgHeight {
            swapValue(&newHeight, &newWidth)
        }
      
        picture = UIImageView(frame: CGRect(x: 5, y: 5, width: newWidth, height: newHeight))
        picture.contentMode = .scaleAspectFit
        chatContainer.addSubview(picture)
        
        picture.centerYAnchor.constraint(equalTo: chatContainer.centerYAnchor).isActive = true
        picture.centerXAnchor.constraint(equalTo: chatContainer.centerXAnchor).isActive = true
        
        chatContainer.layoutIfNeeded()
        chatContainer.setNeedsUpdateConstraints()
        
        self.picture.kf.setImage(with: URL(string: imgUrl))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        picture.isUserInteractionEnabled = true
        picture.addGestureRecognizer(tap)
    }
    
   func addVideoImage(){
        videoPicture = UIImageView(frame: CGRect(x: 20.0, y: 10.0, width: 30.0, height: 30.0))
        videoPicture.image = #imageLiteral(resourceName: "icon_play")
        videoPicture.contentMode = .scaleAspectFit
       chatContainer.addSubview(videoPicture)
        self.layoutIfNeeded()
        
        videoPicture.centerYAnchor.constraint(equalTo: chatContainer.centerYAnchor).isActive = true
        videoPicture.centerXAnchor.constraint(equalTo: chatContainer.centerXAnchor).isActive = true
       chatContainer.setNeedsUpdateConstraints()
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
        videoPicture.isUserInteractionEnabled = true
        videoPicture.addGestureRecognizer(tap)
    }
    
    func swapValue(_ a: inout CGFloat, _ b: inout CGFloat) {
        (a, b) = (b, a)
    }
    
    @objc func imageTapped(){
        
    }
    
    @objc func videoTapped(){
        
    }

}
