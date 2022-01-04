//
//  APIConstant.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

enum APIConstant: String {
    case version = "1"
    case user = "https://terraresta.com/app/api"

    case login = "LoginCtrl/login"
    case recipe = "recipe"
    case register = "SignUpCtrl/SignUp"
    case profile = "ProfileCtrl/ProfileDisplay"
    case favorite = "fav"
    case detail = "detail"
    case deleteAccount = "AccountCtrl/DeleteAccount"
    case editProfile = "ProfileCtrl/ProfileEdit"
    case imageUpload = "MediaCtrl/ImageUpload"
    case webviewUrl = "https://www.apple.com"
    case feed = "ProfileFeedCtrl/ProfileFeed"
    case messageCtrl = "TalkCtrl/TalkList"
    case deleteMessageCtrl = "TalkCtrl/Delete"
    case talkCtrl="TalkCtrl/Talk"
    case sendMessage="TalkCtrl/SendMessage"
}
