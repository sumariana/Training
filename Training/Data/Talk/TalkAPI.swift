//
//  TalkAPI.swift
//  Training
//
//  Created by TimedoorMSI on 18/12/21.
//

import Foundation
import Alamofire
import RxSwift

class TalkAPI: APIRequest{
    var presenter: TalkPresenterProtocol
    
    init(_ presenter: TalkPresenterProtocol){
        self.presenter = presenter
    }
    
    func fetchTalkList(_ toUserId: Int,_ borderMessage: Int,_ howToRequest: Int) -> Observable<TalkResponse>{
        print("userid \(toUserId)")
        let parameters: [String:Any] = [
            "to_user_id" : String(toUserId),
            "border_message_id": String(borderMessage),
            "how_to_request": String(howToRequest)
        ]
        
        let request = get(key: APIConstant.talkCtrl.rawValue, query: parameters, isWithToken: true)
        
        return Alamofire.request(request).rx.response()
    }
    
    func sendMessage(toUserId: Int,message: String?,imageId: Int?,videoId: Int?)-> Observable<SendMessageResponse>{
        let queries : [String: Any] = [
            "access_token": User.shared.token(),
            "to_user_id": String(toUserId)
        ]
        var request = post(path: APIConstant.sendMessage.rawValue, query: queries).asFormURLEncoded()
        var params = [String : Any]()
        print("disini print imagenya bos \(imageId ?? 0)")
        if(message != nil){
            params["message"] = String(message ?? "")}
        if(imageId != nil){
            params["image_id"] = String(imageId ?? 0)}
        if(videoId != nil){
            params["video_id"] = String(videoId ?? 0)}
        request.httpBody = params.percentEscaped().data(using: .utf8)
        return Alamofire.request(request).rx.response()
    }
}
