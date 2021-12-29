//
//  Double+.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

extension Double {

    func withDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
}