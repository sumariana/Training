//
//  TalkPresenter.swift
//  Training
//
//  Created by TimedoorMSI on 15/12/21.
//

import Foundation
class TalkPresenter: TalkPresenterProtocol{
    var view: TalkViewProtocol!
    var handler: TalkAPI!
    init(_ view: TalkViewProtocol) {
        self.view = view
        self.handler = TalkAPI(self)
    }
    func sendMessage(toUserId: Int, message: String) {
        _ = handler.sendMessage(toUserId: toUserId, message: message, imageId: nil, videoId: nil).subscribe(onNext: { result in
            if result.status == 1 {
                self.view.successSendMessage()
            }else{
                self.view.errorResponse(nil)
            }
        }, onError: { _error in
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func sendImage(toUserid: Int, imageId: Int) {
        _ = handler.sendMessage(toUserId: toUserid, message: nil, imageId: imageId, videoId: nil).subscribe(onNext: { result in
            if result.status == 1 {
                self.view.successSendMessage()
            }else{
                self.view.errorResponse(nil)
            }
        }, onError: { _error in
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func sendVideo(toUserId: Int, videoId: Int) {
        _ = handler.sendMessage(toUserId: toUserId, message: nil, imageId: nil, videoId: videoId).subscribe(onNext: { result in
            if result.status == 1 {
                self.view.successSendMessage()
            }else{
                self.view.errorResponse(nil)
            }
        }, onError: { _error in
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func loadTalkList(toUserId: Int, borderMessage: Int, howToRequest: Int) {
        
        _ = handler.fetchTalkList(toUserId,borderMessage, howToRequest).subscribe(onNext: { result in
            NSLog("im here memex")
            if result.status == 1 {
                self.view.buildView(talkList: result.items)
            }else{
                self.view.errorResponse(nil)
            }
        }, onError: { _error in
            NSLog("error memex")
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func getLocalTalks() {
        
    }
    
    
}
