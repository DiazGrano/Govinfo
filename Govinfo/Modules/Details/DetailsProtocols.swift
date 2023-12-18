//
//  DetailsProtocols.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import Foundation

protocol DetailsViewControllerProtocol: AnyObject {
    func showDetails(elements: [GovinfoLabelViewUI])
    func showError(error: ErrorResponse)
}

protocol DetailsViewUIProtocol: AnyObject {
    func shareDetailsToWhatsApp()
}

protocol DetailsInteractorProtocol: AnyObject {
    
}

protocol DetailsPresenterProtocol: AnyObject {
    func fetchDetails()
    func sendDetailsToWhatsApp()
}

protocol DetailsRouterProtocol: AnyObject {
    
}
