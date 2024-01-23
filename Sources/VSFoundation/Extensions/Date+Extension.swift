//
//  Date+Extension.swift
//  
//
//  Created by Théodore Roos on 2023-01-20.
//

import Foundation

public extension Date {
  var currentTimeMillis: Int { Int(timeIntervalSince1970 * 1000) }
}
