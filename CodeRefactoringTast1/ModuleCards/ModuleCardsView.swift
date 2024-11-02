//
//  ModuleCardsView.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//

import UIKit

final class ModuleCardsView: UIView {

    private let presenter: ModuleCardsPresenterProtocol

    init(presenter: ModuleCardsPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(cards: [CardResponse]) {
        // Отобразить карты на UI
        print("Карты загружены: \(cards)")
    }

    func showError(error: Error) {
        // Показать ошибку на UI
        print("Ошибка загрузки карт: \(error.localizedDescription)")
    }

    func showEmpty() {

    }

    func startLoader() {

    }

    func stopLoader() {

    }
}
