//
//  GovinfoConstants.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

enum GovinfoConstants {
    enum lotties {
        static let cat = "gatongo"
        static let biometric = "biometric"
    }
    
    enum Dimensions {
        static let cornerRadius: CGFloat = 12
        static let borderWidth: CGFloat = 2
    }
    
    enum Fonts {
        static let comic = "Comic Sans MS"
    }
    
    enum ErrorCodes {
        static let unknown = "-64701"
        static let badURL = "-64702"
        static let badResponseBody = "-64703"
        static let badRequestBody = "-64704"
        static let noInternet = "-64705"
        static let biometric = "-64706"
        static let whatsapp = "-64707"
        static let login = "-64708"
        static let register = "-64709"
    }
}
