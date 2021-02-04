//
//  InventoryItem.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-15.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//
import Foundation

struct InventoryItem: Decodable {
    
    let  inventoryId: UInt64
    let  itemNumber: String
    let  customerName: String?
    let  customerId: Int?
    let  materialDescription: String
    let  materialId: Int?
    let  deleted: String
    let  createdDate: Date
    let  contentType: String
    let  contentTypeId: Int
    let  entryDate: Date
    let  tareValueId: Int?
    let  netWeight: Double
    let  grossWeight: Double?
    let  netWeightKg: Double
    let  netWeightLbs: Double
    let  grossWeightKg: Double
    let  grossWeightLbs: Double
    let  unitDescription: String
    let  productLocationDescription: String?
    let  productNumberDescription: String?
    let  productNumberId: Int?
    let  productLocationId: Int?
    let  shipped: Bool
 
}

