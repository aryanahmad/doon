//
//  Material.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-12-07.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

struct Customer: Codable {
    

    let  customerId: Int
    let  orgId: Int
    let  name: String
    let  address: String
    let  phoneNumber: String
    let  email: String
    let  street: String
    let  stateProvice: String
    let  postalCode:String
    let  city: String
    let  country: String?
    let  retired: Bool
    
}

