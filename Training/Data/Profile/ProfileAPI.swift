//
//  ProfileAPI.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ProfileAPI: APIRequest {
    
    // MARK: Properties
    
    var presenter: ProfilePresenterProtocol
    
    
    // MARK: Initialize
    
    init(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: Methods
    
    func fetch(userId: Int? = nil) -> Observable<ProfileModel> {
        var id = 0
        if userId == nil {
            id = Int(User.shared.userId()) ??  0
        }else{
            id = userId!
        }
        
        let parameters: [String: Any] = [
            "user_id": String(id)
        ]
        
        let request = get(key: APIConstant.profile.rawValue, query: parameters, isWithToken: true)
        
        return Alamofire.request(request).rx.response()
    }
    
    func fetch() -> Observable<ProfileModel> {
        let parameters: [String: Any]=[
            "access_token": User.shared.token(),
            "user_id" : User.shared.userId()
        ]
        let request = get(key: APIConstant.profile.rawValue,query: parameters)
        return Alamofire.request(request).rx.response()
    }
    
    func edit(name: String, phone: String, email: String) -> Observable<BaseProfileModel> {
        var request = patch(path: APIConstant.profile.rawValue).withToken().asFormURLEncoded()
        let parameters: [String: Any] = [
            "name": name,
            "phone": phone,
            "email": email
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return Alamofire.request(request).rx.response()
    }
    
    func deleteAccount() -> Observable<DeleteAccountResponse>{
        let parameters: [String: Any] = [
            "access_token": User.shared.token(),
        ]
        
        let request = get(key: APIConstant.deleteAccount.rawValue, query: parameters)
        return Alamofire.request(request).rx.response()
    }
    
    func editProfile(profileRequest: ProfileRequest) -> Observable<EmptyResponse>{
        let queries : [String: Any] = [
            "access_token": User.shared.token(),
        ]
        var request = post(path: APIConstant.editProfile.rawValue, query: queries).asFormURLEncoded()
        let parameters: [String: Any] = profileRequest.dictionary
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return Alamofire.request(request).rx.response()
    }
}
