//
//  EnemyLossesRouter.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation
import UIKit

protocol EnemyLossesRouterProtocol: AnyObject {
    func showDetailedInfoViewController(navigationController: UINavigationController, for item: EnemyLossesModel.OutputModel)
}

final class EnemyLossesRouter {
    // MARK: - Public properties

    var factory: MainFactoryProtocol

    // MARK: - Lifecycle

    init(factory: MainFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - EnemyLossesRouterProtocol

extension EnemyLossesRouter: EnemyLossesRouterProtocol {
    func showDetailedInfoViewController(navigationController: UINavigationController, for item: EnemyLossesModel.OutputModel) {
        let detailedInfoViewController = factory.makeDetailedInfoViewController()
        let inputModel = DetailedInfo.InputModel(selectedItem: item.selectedItem)
        detailedInfoViewController.inputModel = inputModel
        navigationController.show(detailedInfoViewController, sender: nil)
    }

}
