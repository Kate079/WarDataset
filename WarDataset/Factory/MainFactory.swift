//
//  MainFactory.swift
//  WarDataset
//
//  Created by Kate on 22.07.2022.
//

import Foundation
import UIKit

protocol MainFactoryProtocol {
    func makeEnemyLossesViewController() -> EnemyLossesViewController
    func makeDetailedInfoViewController() -> DetailedInfoViewController
}

final class MainFactory: MainFactoryProtocol {
    func makeEnemyLossesViewController() -> EnemyLossesViewController {
        let controller = EnemyLossesViewController()
        let interactor = EnemyLossesInteractor()
        let presenter = EnemyLossesPresenter()
        let router = EnemyLossesRouter(factory: self)

        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        presenter.viewController = controller

        return controller
    }

    func makeDetailedInfoViewController() -> DetailedInfoViewController {
        let controller = DetailedInfoViewController()
        let interactor = DetailedInfoInteractor()
        let presenter = DetailedInfoPresenter()

        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller

        return controller
    }
}
