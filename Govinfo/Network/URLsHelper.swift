//
//  URLsHelper.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

enum BasePath: String {
    case govData = "https://api.datos.gob.mx/"
    case google = "https://www.google.com.mx/"
}

enum Endpoint: String {
    case facts = "v1/gobmx.facts"
}

class URLsHelper {
    static let govFacts = (BasePath.govData.rawValue + Endpoint.facts.rawValue + "?pageSize=999")
}

