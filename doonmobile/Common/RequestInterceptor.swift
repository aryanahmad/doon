//
//  RequestInterceptor.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-10.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation
import Alamofire
import UIKit



/// The storage containing your access token, preferable a Keychain wrapper.
protocol AccessTokenStorage: class {
    typealias JWT = String
    var accessToken: JWT { get set }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {

    private let storage: AccessTokenStorage

    init(storage: AccessTokenStorage) {
        self.storage = storage
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://api.authenticated.com") == true else {
            /// If the request does not require authentication, we can directly return it as unmodified.
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest

        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}
 
