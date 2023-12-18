//
//  SplashInteractor.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

class SplashInteractor {
    private weak var presenter: SplashPresenterProtocol?
    private let networkManager = NetworkManager()
    
    func setPresenter(_ presenter: SplashPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SplashInteractor: SplashInteractorProtocol {
    func getFacts() {
        networkManager.request(url: URLsHelper.govFacts, method: .get, responseType: GovFactsResponse.self) { [unowned self] modelResponse in
            self.presenter?.fetchedFacts(model: modelResponse)
        } failure: { [unowned self] errorResponse in
            self.presenter?.fetchedError(error: errorResponse)
        }
    }
}
