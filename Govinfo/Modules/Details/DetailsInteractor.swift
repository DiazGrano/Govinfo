//
//  DetailsInteractor.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import Foundation

class DetailsInteractor {
    private(set) weak var presenter: DetailsPresenterProtocol?
    
    func setPresenter(_ presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension DetailsInteractor: DetailsInteractorProtocol {
    
}
