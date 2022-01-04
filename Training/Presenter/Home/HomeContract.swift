//
//  HomeContract.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

protocol HomeViewProtocol {
    func buildView(list: [HomeModel])
    func buildError(_ error: ErrorModel)
}

protocol HomePresenterProtocol {
    func fetchHome()
}
