//
//  InventoryItem.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-15.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//
import Foundation

struct IncomingShipment: Decodable {
    
    let receivedDate: Date;
    let customerId: Int
    let customerName: String
    let comments: String
    let referenceNumber: String
    let carrierName: String?
    let carrierId: UInt64?
    let referenceId: String
    let createdDate: Date
    let createdUserId: UInt64
    let createdByUserName: String
    let items : [IncomingShipmentDetail]
    
}

