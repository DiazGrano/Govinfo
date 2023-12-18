//
//  URLOpenerHelperMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import UIKit
@testable import Govinfo

class URLOpenerHelperMock: URLOpenerHelper {
    var canOpen: Bool
    
    init(canOpen: Bool = true) {
        self.canOpen = canOpen
    }
    
    override func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler: ((Bool) -> Void)? = nil) {
        completionHandler?(canOpen)
    }
    
    override func canOpen(_ url: URL) -> Bool {
        return canOpen
    }
}
