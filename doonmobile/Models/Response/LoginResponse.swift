//
//  LoginResponse.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-14.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

struct LoginResponse : Decodable{
    let accessToken: String
    let tokenType: String
    let expiration: Date
}
