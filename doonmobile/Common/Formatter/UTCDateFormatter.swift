//
//  UTCDateFormatter.swift
//  doonmobile
//
//  Created by Fahad  Akhtar on 2020-09-14.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var utcDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }
}
