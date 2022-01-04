//
//  RequestProtocol.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Alamofire
import RxSwift

extension Request: ReactiveCompatible{}
extension SessionManager: ReactiveCompatible{}

extension Reactive where Base: DataRequest {
    func response<T: Codable>() -> Observable<T> {
        return Observable.create { observer in
            let request = self.base.responseJSON { response in
                
                // REQUEST ERROR
                if let error = response.result.error {
                    if error._code == NSURLErrorTimedOut {
                        let error = ErrorModel(code: NSURLErrorTimedOut)
                        observer.onError(error)
                    } else if error._code == NSURLErrorNotConnectedToInternet {
                        let error = ErrorModel(code: NSURLErrorNotConnectedToInternet)
                        observer.onError(error)
                    }
                    
                    // NO REQUEST ERROR
                } else {
                    if let statusCode = response.response?.statusCode {
                        guard let data = response.data else { return }
                        let decoder = JSONDecoder()
                        do {
                            let results: T = try decoder.decode(T.self, from: data)
                            observer.onNext(results)
                            observer.onCompleted()
                        } catch {
                            do {
                                let errorResults: ErrorModel = try decoder.decode(ErrorModel.self, from: data)
                                observer.onError(errorResults)
                            } catch {
                                let results = ErrorModel(code: statusCode)
                                observer.onError(results)
                            }
                        }
                        return
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

extension Reactive where Base: SessionManager {
    func encodeMultipartUpload<T: Codable>(to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders = [:], data: @escaping (MultipartFormData) -> Void) -> Observable<T> {
        print("encodeMultipartUploaad")
        
        return Observable.create { observer in
            self.base.upload(multipartFormData: data,
                             to: url,
                             method: method,
                             headers: headers,
                             encodingCompletion: { (result: SessionManager.MultipartFormDataEncodingResult) in
                                 switch result {
                                 case let .failure(error):
                                     observer.onError(error)
                                 case let .success(request, _, _):
                                     request.responseJSON { response in

                                         // REQUEST ERROR
                                         if let error = response.result.error {
                                             if error._code == NSURLErrorTimedOut {
                                                 let error = ErrorPerResponse(errorCode: NSURLErrorTimedOut, errorTitle: "Request Time Out", errorMessage: "Request Time Out")
                                                 observer.onError(error)
                                             } else if error._code == NSURLErrorNotConnectedToInternet {
                                                 let error = ErrorPerResponse(errorCode: NSURLErrorTimedOut, errorTitle: "Request Time Out", errorMessage: "Request Time Out")
                                                 observer.onError(error)
                                             }

                                             // NO REQUEST ERROR
                                         } else {
                                             if let statusCode = response.response?.statusCode {
                                                 guard let data = response.data else { return }
                                                 let decoder = JSONDecoder()
                                                 do {
                                                     let results: T = try decoder.decode(T.self, from: data)
                                                     observer.onNext(results)
                                                     observer.onCompleted()
                                                 } catch {
                                                     do {
                                                         print("masuk sini 22")
                                                         let errorResults: ErrorPerResponse = try decoder.decode(ErrorPerResponse.self, from: data)
                                                         observer.onError(errorResults)
                                                     } catch {
                                                         print("masuk sini 1")
                                                         let error = ErrorPerResponse(errorCode: statusCode, errorTitle: "", errorMessage: "")
                                                         observer.onError(error)
                                                     }
                                                 }
                                                 return
                                             }
                                         }
                                     }
                                 }
                             })

            return Disposables.create()
        }
    }
}

