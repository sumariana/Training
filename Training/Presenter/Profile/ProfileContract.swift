//
//  ProfileContract.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewProtocol {
    func buildView(data: ProfileModel)
    func buildError(_ error: ErrorPerResponse?)
    func editProfileResponse(response: EmptyResponse)
    func deleteAccountResponse()
}

protocol ProfilePresenterProtocol {
    func fetchProfile()
    func fetchProfile(userId: Int?)
    func deleteAccount()
    func editProfile(editProfileRequest: ProfileRequest)
    func editImage(_ image: UIImage)
}
