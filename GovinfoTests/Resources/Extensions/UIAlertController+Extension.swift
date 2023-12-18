//
//  UIAlertController+Extension.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import UIKit

extension UIAlertController {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    func tapButtons() {
        for action in actions {
            guard let block = action.value(forKey: "handler") else {
                continue
            }
            let handler = unsafeBitCast(block as AnyObject, to: AlertHandler.self)
            handler(action)
        }
    }
}
