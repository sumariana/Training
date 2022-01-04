//
//  MessageContract.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 14/12/21.
//

import Foundation

protocol MessageViewProtocol {
    func buildView(messageLocalItem: [MessageLocalItem])
    func deleteMessageSuccess()
    func errorResponse(_ error: ErrorPerResponse?)
}

protocol MessagePresenterProtocol {
    func fetchMessage(lastLoginTime : String)
    func saveMessageToRealm(messageData: MessageData?)
    func getlocalMessage()
    func deleteMessage(talkId: String)
}
