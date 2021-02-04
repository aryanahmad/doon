//
//  IncomingShipmentDetail.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-18.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

import Foundation

struct IncomingShipmentDetail: Decodable {
    
    let  incomingShipmentDetailId: UInt64
    let  incomingShipmentId: UInt64
    let  quantity: Int
    let  materialId: Int
    let  materialDescription: String
    let  serviceType: String
    let  content: String
    let  contentTypeId: Int
    let  price: Double
    let  currency: String
    let  netWeight: Double
    let  grossWeight: Double
    let  unitDescription: String
    
}
