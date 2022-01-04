//
//  TalkContract.swift
//  Training
//
//  Created by TimedoorMSI on 15/12/21.
//

import Foundation

protocol TalkViewProtocol{
    func successSendMessage()
    func buildView(talkList: [TalkItems])
    func errorResponse(_ error: ErrorPerResponse?)
}

protocol TalkPresenterProtocol{
    func sendMessage(toUserId: Int,message: String)
    func sendImage(toUserid: Int,imageId: Int)
    func sendVideo(toUserId: Int,videoId: Int)
    func loadTalkList(toUserId: Int,borderMessage: Int,howToRequest: Int)
    func getLocalTalks()
}
