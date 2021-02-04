//
//  File.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2020-09-08.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class networkRequest{
    //refactor later / other requests
    
    func callAPI(apipath: String, params: Parameters, methodType: HTTPMethod){
        let head = networkRequest.getAuthHeader();
        AF.request(url + auth + apipath, method: methodType, parameters: params, encoding: JSONEncoding.default, headers: head).validate().responseJSON { response in
            switch response.result{
            case .success:
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    class func getAuthHeader() -> HTTPHeaders {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "accessToken");
        let tokenTpe = "Bearer ";
        let authHeader = "\(tokenTpe) \(token ?? "")"
    
        let headers: HTTPHeaders = [
            "Authorization": authHeader ,
            "Accept": "application/json"
        ]
        
        return headers;
        
    }
    
    
}
