//
//  HomeAPI.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HomeAPI: APIRequest{
    
    // MARK: Properties
    
    var presenter: HomePresenterProtocol
    
    
    // MARK: Initialize
    
    init(_ presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: Methods
    
    func fetch() -> Observable<BaseHomeModel> {
        let request = get(path: APIConstant.recipe.rawValue)
        return Alamofire.request(request).rx.response()
    }
}




