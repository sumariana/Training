//
//  MessageAPI.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 14/12/21.
//

import Foundation
import Alamofire
import RxSwift

class MessageAPI : APIRequest {
    var presenter: MessagePresenterProtocol
    
    init(_ presenter: MessagePresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchMessage(lastLoginTime : String?) -> Observable<MessageData> {
        let parameters: [String:Any] = [
            "last_login_time" : lastLoginTime ?? "",
            "user_id": User.shared.userId()
        ]
        
        let request = get(key: APIConstant.messageCtrl.rawValue, query: parameters, isWithToken: true)
        
        return Alamofire.request(request).rx.response()
    }
    
    func deleteMessage(talkId: String) -> Observable<DeleteAccountResponse>{
        let parameters: [String:Any] = [
            "talk_ids" : talkId
        ]
        
        let requst = get(key: APIConstant.deleteMessageCtrl.rawValue, query: parameters, isWithToken: true)
        
        return Alamofire.request(requst).rx.response()
    }
}
