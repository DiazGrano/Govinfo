//
//  URLOpenerHelper.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import UIKit

class URLOpenerHelper {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler: ((Bool) -> Void)? = nil) {
        UIApplication.shared.open(url, options: options, completionHandler: completionHandler)
    }
    
    func canOpen(_ url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }
}
