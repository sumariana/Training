//
//  FeedAPI.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//

import Foundation
import Alamofire
import RxSwift

class FeedAPI: APIRequest{
    var presenter: FeedPresenter!
    init(_ feedPresenter: FeedPresenter) {
        self.presenter = feedPresenter
    }
    
    func getFeed(_ lastLoginTime: String?) -> Observable<FeedResponse>{
        let parameters: [String: Any] = [
            "access_token": User.shared.token(),
            "last_login_time": lastLoginTime,
        ]
        let request = get(key: APIConstant.feed.rawValue, query: parameters)
        return Alamofire.request(request).rx.response()
    }
}
