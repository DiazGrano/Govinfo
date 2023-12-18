//
//  DetailsPresenter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class DetailsPresenter {
    private weak var view: DetailsViewControllerProtocol?
    private let interactor: DetailsInteractorProtocol
    private let router: DetailsRouterProtocol
    private let fact: Fact
    private let locationHelper = LocationHelper()
    
    init(interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol, fact: Fact) {
        self.interactor = interactor
        self.router = router
        self.fact = fact
    }
    
    func setView(_ view: DetailsViewControllerProtocol) {
        self.view = view
    }

    private func getDetailLabel(title: String, content: String) -> GovinfoLabelViewUI {
        let detail = GovinfoLabelViewUI()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.title = title
        detail.content = content
        return detail
    }
    
    private func sendWhatsAppsMessage(content: String) {
        let whatsAppURLPrefix = "whatsapp://send?text="
        
        guard let encodedMessage = content.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let whatsURL = URL(string: "\(whatsAppURLPrefix)\(encodedMessage)"),
              UIApplication.shared.canOpenURL(whatsURL) else {
            view?.showError(error: ErrorResponse.getDefaultError(type: .whatsapp))
            return
        }
        
        UIApplication.shared.open(whatsURL)
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func sendDetailsToWhatsApp() {
        var message = "Details.shareToWhatsAppMessageTitle".localized + "\n\n"
        for detail in fact.getDictionary() {
            let auxMessage = "*\(detail.key):*" + "\n" + "\(detail.value)" + "\n\n"
            message += auxMessage
        }
        
        locationHelper.getCoordinates { [unowned self] latitude, longitude in
            message += String(format: "Details.coordiantes".localized, latitude, longitude)
            self.sendWhatsAppsMessage(content: message)
        } notAvailable: { [unowned self] in
            self.sendWhatsAppsMessage(content: message)
        }
    }
    
    func fetchDetails() {
        var detailLabels: [GovinfoLabelViewUI] = []
        
        for property in fact.getDictionary() {
            let detailLabel = getDetailLabel(title: property.key.beautify(), content: property.value)
            detailLabels.append(detailLabel)
        }
        
        view?.showDetails(elements: detailLabels)
    }
}
