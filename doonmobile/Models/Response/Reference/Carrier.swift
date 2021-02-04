//
//  Carrier.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-12-07.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

struct Carrier: Codable {
    

    let  id: UInt64?
    let  phoneNumber: String
    let  email: String
    let  street: String
    let  stateProvice: String
    let  postalCode:String
    let  city: String
    let  country: String
    let name: String
    let  retired: Bool
    
    
}
