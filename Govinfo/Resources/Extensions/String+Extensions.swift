//
//  String+Extensions.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: " ")
    }
    
    func beautify() -> String {
        var beautyString = self.replacingOccurrences(of: "_", with: " ")
        beautyString = beautyString.capitalized
        return beautyString
    }
}
