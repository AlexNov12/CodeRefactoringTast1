//
//  ModuleCardsPresenter.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//

import Foundation
import UIKit

protocol ModuleCardsPresenterProtocol {
    
    func viewDidLoad()
    func loadCards()
}

final class ModuleCardsPresenter: ModuleCardsPresenterProtocol {
    
    weak var view: ModuleCardsViewProtocol?
    private let service: CardsServiceProtocol
    private let cardIDs: [String]
    
    required init(service: CardsServiceProtocol, cardIDs: [String]) {
        self.service = service
        self.cardIDs = cardIDs
    }
    
    func viewDidLoad() {
        view?.startLoader()
        loadCards()
    }
    
    func loadCards() {
        guard !cardIDs.isEmpty else {
            view?.showEmpty()
            view?.stopLoader()
            return
        }
        
        var loadedCards = [CardResponse]()
        let group = DispatchGroup()
        let lock = NSLock()
        
        for cardID in cardIDs {
            group.enter()
            service.loadCardsInfo(byCardID: cardID) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self else { return }
                    
                    switch result {
                    case .success(let cardResponse):
                        lock.lock()
                        loadedCards.append(cardResponse)
                        lock.unlock()
                    case .failure(let error):
                        self.view?.stopLoader()
                        self.view?.showError(error: error)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.view?.stopLoader()
            self.view?.update(cards: loadedCards)
        }
    }
}
