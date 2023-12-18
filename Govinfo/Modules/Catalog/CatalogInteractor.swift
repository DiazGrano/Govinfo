//
//  CatalogInteractor.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import Foundation

class CatalogInteractor {
    private(set) weak var presenter: CatalogPresenterProtocol?
    
    func setPresenter(_ presenter: CatalogPresenterProtocol) {
        self.presenter = presenter
    }
}

extension CatalogInteractor: CatalogInteractorProtocol {
    
}
