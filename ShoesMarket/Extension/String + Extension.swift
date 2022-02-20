//
//  String + Extension.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 30.01.2022.
//

import Foundation

extension String {
    func formatPhone() -> String {
        let cleanNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let format: [Character] = ["(","X", "X", "X", ")", " ", "X", "X", "X", "-", "X", "X", "-" , "X", "X"]
        
        var result = ""
        var index = cleanNumber.startIndex
        for ch in format {
            if index == cleanNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
