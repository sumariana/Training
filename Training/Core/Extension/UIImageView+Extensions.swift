//
//  UIImageView+Extensions.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func loadProfileImage(_ urlStr: String?){
        let placeholder = UIImage(systemName: "person.fill")
        let url = URL(string: urlStr ?? "")
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1)),])
    }
}
