//
//  HomePresenter.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HomePresenter {
    
    // MARK: Initializer
    
    var view: HomeViewProtocol
    
    var handler: HomeAPI!
    
    init(_ view: HomeViewProtocol) {
        self.view = view
        self.handler = HomeAPI(self)
    }
}

extension HomePresenter: HomePresenterProtocol {
    func fetchHome() {
        _ = handler.fetch()
            .subscribe(onNext: { json in
                self.view.buildView(list: json.data)
        }, onError: { _error in
            let error = _error as! ErrorModel
            print(error)
        }, onCompleted: nil, onDisposed: nil)
    }
}
