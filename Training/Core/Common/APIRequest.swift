//
//  APIRequest.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 14/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol APIRequest {
}

extension APIRequest {
    var base: String { return APIConstant.user.rawValue }
    
    func get(path: String) -> URLRequest {
        var request = URLRequest(url: NSURL.init(string: "\(base)v\(APIConstant.version.rawValue)/\(path)")! as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    func get(key: String, query: [String:Any]? = nil) -> URLRequest {
            var request: URLRequest!
            var url: URLComponents!

            url = URLComponents(string: "\(base)/\(key)")

            if query != nil {
                var queryItems = [URLQueryItem]()
                for data in query! {
                    queryItems.append(URLQueryItem(name: data.key, value: data.value as? String))
                }
                url.queryItems = queryItems
            }
            
            request = URLRequest(url: url.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 30
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            return request
        }
    
    func get(key: String, query: [String: Any]? = nil, isWithToken: Bool? = false) -> URLRequest {
        var request: URLRequest!
        var url: URLComponents!

        url = URLComponents(string: "\(base)/\(key)")
        var queryItems = [URLQueryItem]()

        if query != nil {
            for data in query! {
                queryItems.append(URLQueryItem(name: data.key, value: data.value as? String))
            }
        }
        url.queryItems = queryItems

        if isWithToken == true {
            url.queryItems?.append(URLQueryItem(name: "access_token", value: User.shared.token()))
        }
        url.queryItems?.append(URLQueryItem(name: "language", value: "en"))
        request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }

    
    func getMultipartHeader() -> HTTPHeaders {
        let header: HTTPHeaders = [
            "Content-type": "multipart/form-data",
        ]
        return header
    }
    
    func postUrl(key: String, query: [String: Any]? = nil, isWithToken: Bool? = nil) -> URL {
        var url: URLComponents!

        url = URLComponents(string: "\(base)/\(key)")
        var queryItems = [URLQueryItem]()

        if query != nil {
            for data in query! {
                queryItems.append(URLQueryItem(name: data.key, value: data.value as? String))
            }
        }

        url.queryItems = queryItems

        if isWithToken == true {
            url.queryItems?.append(URLQueryItem(name: "access_token", value: User.shared.token()))
        }
        url.queryItems?.append(URLQueryItem(name: "language", value: "en"))

        return url.url!
    }
    
    func post(path: String,query: [String:Any]? = nil) -> URLRequest {
        var url: URLComponents!
        url = URLComponents(string: "\(base)/\(path)")
        if query != nil {
            var queryItems = [URLQueryItem]()
            for data in query! {
                queryItems.append(URLQueryItem(name: data.key, value: data.value as? String))
            }
            url.queryItems = queryItems
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func patch(path: String) -> URLRequest {
        var request = URLRequest(url: NSURL.init(string: "\(base)\(path)")! as URL)
        request.httpMethod = "PATCH"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    
}
