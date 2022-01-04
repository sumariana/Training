//
//  ProfilePresenter.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ProfilePresenter {
    
    // MARK: Properties
    
    var view: ProfileViewProtocol
    
    var handler: ProfileAPI!
    
    
    // MARK: Initialize
    
    init(_ view: ProfileViewProtocol) {
        self.view = view
        self.handler = ProfileAPI(self)
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func fetchProfile() {
        _ = handler.fetch().subscribe(onNext: { result in
            NSLog("i am here1")
            self.view.buildView(data: result)
        }, onError: { _error in
            NSLog("theres error")
            self.view.buildError(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func fetchProfile(userId: Int? = nil) {
        _ = handler.fetch(userId: userId).subscribe(onNext: { result in
            if result.status == 1 {
                NSLog("status 1")
                self.view.buildView(data: result)
            } else {
                NSLog("status tidak jelas")
                self.view.buildError(result.error)
            }
        }, onError: { _error in
            NSLog(_error.localizedDescription)
            self.view.buildError(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func editImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return  }
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
        }, to: APIConstant.user.rawValue+APIConstant.imageUpload.rawValue+"?access_token="+User.shared.token()+"&location=Profile",
        encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        guard let data = response.data else { return }
                        let decoder = JSONDecoder()
                        do {
                            let results: ImageResponse = try decoder.decode(ImageResponse.self, from: data)
                            var profileRequest = ProfileRequest()
                            profileRequest.image_id = results.imageId!
                        } catch {
                            var error = ErrorPerResponse()
                            error.errorCode = HTTPStatusCode.parsingError.rawValue
                            self.view.buildError(error)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    var error = ErrorPerResponse()
                    error.errorMessage = encodingError.localizedDescription
                    self.view.buildError(error)
                }
            }
        )
    }
    
    func editProfile(editProfileRequest: ProfileRequest) {
        _ = handler.editProfile(profileRequest: editProfileRequest)
            .subscribe(onNext: {result in
                if(result.status == 1){
                    self.view.editProfileResponse(response: result)
                }else{
                    self.view.buildError(result.error)
                }
            }, onError: {_error in self.view.buildError(nil)
                
            }, onCompleted: nil, onDisposed: nil)
    }
    
    func deleteAccount() {
        _ = handler.deleteAccount()
            .subscribe(onNext: {result in
                if(result.status == 1){
                    self.view.deleteAccountResponse()
                }else{
                    self.view.buildError(result.error)
                }
            }, onError: {_error in self.view.buildError(nil)
                
            }, onCompleted: nil, onDisposed: nil)
    }
}
