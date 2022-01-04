//
//  FeedContract.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//
import Foundation

protocol FeedViewProtocol {
    func getFeedResponse(response: FeedResponse)
    func errorResponse(_ error: ErrorPerResponse?)
}

protocol FeedPresenterProtocol {
    func getFeed(lastLoginTime: String?)
}
