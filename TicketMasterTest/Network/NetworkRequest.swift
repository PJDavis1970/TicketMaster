//
//  NetworkRequest.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import Alamofire

typealias ResponseHandler = (Any?, Error?) -> ()
typealias ProgressHandler = (Progress) -> Void
typealias FailedHandler = (Error?) -> ()

protocol NetworkRequest {
    
    func sendRequest(progress: ProgressHandler?, finished: ResponseHandler!)
}

extension NetworkRequest {
        
    private static var ACCESS_TOKEN_HEADER: String { return "Authorization" }

    
    private static func RequestHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        return headers
    }
    
    func httpRequest(url: URL, method: HTTPMethod, param: [String: Any], header: HTTPHeaders? = RequestHeaders(), finished: ResponseHandler!, calls: Int = 0, error: Error? = nil) {
        
        guard calls < 3 else {
            if let error = error {
                finished(nil, error)
            } else {
                finished(nil, NSError(domain: "Error", code: 400, userInfo: [NSLocalizedDescriptionKey: Strings.connectionFailed]))
            }
            return
        }
        
        let responseHandler: ((AFDataResponse<Data>)->()) = { (response) in
            switch response.result {
            case .success(let value):
                print("API call success: \(url.absoluteString)\nParameters:\(param)\n------\n\n")
                print("Response:\n\(String(data: value, encoding: .utf8)!)\n\n")
                
                var dict = try? JSONSerialization.jsonObject(with: value, options: []) as? [String: Any]
                if dict == nil {
                    dict = [:] as [String: Any]
                }
                
                switch (response.response?.statusCode)! {
                case 200...300:
                    finished(dict, nil)
                    
                default:
                    var msg: String = Strings.errorGeneral
                    if let errorCode = response.response?.statusCode {
                        switch(errorCode) {
                        case 401:
                            msg = Strings.errorNoAuth
                            break;
                        case 403:
                            msg = Strings.errorNoAuth
                            break;
                        case 404:
                            msg = Strings.errorNotFound
                        default:
                            msg = Strings.errorGeneral
                        }
                    }
                    finished(nil, NSError(domain: "Error", code: response.response?.statusCode ?? 400, userInfo: [NSLocalizedDescriptionKey: msg]))
                }
                
            case .failure(let error):
                print("API call failure: \(url.absoluteString)\nParameters:\(param)\n------\n\n")
                print("Response:\n\(error)\n\n")
                
                if let errorCode = response.response?.statusCode, errorCode == 401 {
                    finished(nil, error)
                    return
                }
                self.httpRequest(url: url, method: method, param: param, header: header, finished: finished, calls: calls + 1, error: error)
            }
        }
        
        if method == .post || method == .put || method == .patch{
            AF.request(url, method: method, parameters: param, encoding: JSONEncoding.default, headers: header).responseData(completionHandler: responseHandler)
        } else {
            AF.request(url, method: method, parameters: param, headers: header).responseData(completionHandler: responseHandler)
        }
    }
}
