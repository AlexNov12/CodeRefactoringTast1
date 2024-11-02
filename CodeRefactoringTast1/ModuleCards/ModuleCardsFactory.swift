//
//  ModuleCardsFactory.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//

import UIKit

final class ModuleCardsFactory {

    func make(cardIDs: [String]) -> UIViewController {
        let cardsService = CardsService()
        let presenter = ModuleCardsPresenter(
            service: cardsService,
            cardIDs: cardIDs
        )

        let viewController = ModuleCardsViewController(presenter: presenter)

        presenter.view = viewController
        return viewController
    }
}
