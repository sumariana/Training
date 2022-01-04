//
//  MessagePresenter.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 14/12/21.
//

import Foundation
import RealmSwift

class MessagePresenter {
    var view :  MessageViewProtocol
    
    var handler : MessageAPI!
    
    let realm = try! Realm()
    
    init(_ view: MessageViewProtocol) {
        self.view = view
        handler = MessageAPI(self)
    }
    
}

extension MessagePresenter: MessagePresenterProtocol{
    func deleteMessage(talkId: String) {
        _ = handler.deleteMessage(talkId: talkId).subscribe(onNext: {result in
            if result.status == 1{
//                self.saveMessageToRealm(messageData: nil)
                self.view.deleteMessageSuccess()
            }else{
                self.view.errorResponse(result.error)
            }
        }, onError: { _error in
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func saveMessageToRealm(messageData: MessageData?) {
        let items = messageData?.items ?? []
        
        realm.beginWrite()
        realm.delete(realm.objects(MessageLocalItem.self))
        
        for item in items{
            let message = MessageLocalItem()
            
            message.talkId = item.talkId
            message.toUserId = item.toUserId
            message.messageId = item.messageId
            message.userId = item.userId
            message.nickname = item.nickname
            message.imageId = item.imageId
            message.imageSize = item.imageSize ?? ""
            message.imageUrl = item.imageUrl ?? ""
            message.message = item.message
            message.mediaType = item.mediaType
            message.userStatus = item.userStatus
            message.time = item.time
            message.lastUpdateTime = item.lastUpdateTime
            
            realm.add(message)
        }
        
        getlocalMessage()
        
        try! realm.commitWrite()
    }
    
    func getlocalMessage(){
        var message: [MessageLocalItem] = []
        let messageRealm = realm.objects(MessageLocalItem.self)
        
        for item in messageRealm {
            message.append(item)
        }
        
        view.buildView(messageLocalItem: message)
    }
    
    func fetchMessage(lastLoginTime : String) {
        _ = handler.fetchMessage(lastLoginTime: lastLoginTime).subscribe(onNext: { result in if result.status == 1 {
            self.saveMessageToRealm(messageData: result)
        }else{
            if result.error.errorCode == 2 {
                self.saveMessageToRealm(messageData: nil)
            }else{
                self.view.errorResponse(result.error)
            }
        }}, onError: { _error in
            self.view.errorResponse(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    
}
