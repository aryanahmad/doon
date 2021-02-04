//
//  FormReferenceData.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-12-07.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

struct FormReferenceData: Codable {
    
let materials: [Material]?
let customers: [Customer]?
let transportTypes: [TransportType]?
let packageTypes: [PackageType]?
let contentTypes: [ContentType]?
let tareValues: [TareType]?
let carriers: [Carrier]?
let productNumbers: [ProductNumber]?
let productLocations: [ProductLocation]?

}
