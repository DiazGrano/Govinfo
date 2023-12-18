//
//  Bundle+Extensions.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

extension Bundle {
    static var govinfo: Bundle {
        Bundle(for: AppDelegate.self)
    }
}
