//
//  FeedPresenter.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//

import UIKit

class FeedPresenter: FeedPresenterProtocol{
    var view: FeedViewProtocol!
    var handler: FeedAPI!
    init(_ view: FeedViewProtocol) {
        self.view = view
        self.handler = FeedAPI(self)
    }
    
    func getFeed(lastLoginTime: String?) {
        _ = handler.getFeed(lastLoginTime)
            .subscribe(onNext: {result in
                if(result.status == 1){
                    self.view.getFeedResponse(response: result)
                }else{
                    self.view.errorResponse(result.error)
                }
            }, onError: {_error in self.view.errorResponse(nil)})
    }
}
