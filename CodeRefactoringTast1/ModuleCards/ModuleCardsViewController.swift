//
//  ModuleCardsViewController.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//

import UIKit

protocol ModuleCardsViewProtocol: AnyObject {
    func update(cards: [CardResponse])
    func showError(error: Error)
    func showEmpty()
    func startLoader()
    func stopLoader()
}

final class ModuleCardsViewController: UIViewController {

    private let presenter: ModuleCardsPresenterProtocol
    private lazy var customView = ModuleCardsView(presenter: presenter)

    init(presenter: ModuleCardsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ModuleCardsViewController: ModuleCardsViewProtocol {

    func showError(error: Error) {
        customView.showError(error: error)
    }

    func showEmpty() {
        customView.showEmpty()
    }

    func update(cards: [CardResponse]) {
        customView.update(cards: cards)
    }

    func startLoader() {
        customView.startLoader()
    }

    func stopLoader() {
        customView.stopLoader()
    }
}
