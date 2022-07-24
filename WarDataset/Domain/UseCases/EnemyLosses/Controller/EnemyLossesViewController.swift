//
//  EnemyLossesViewController.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation
import UIKit

protocol EnemyLossesViewControllerProtocol: AnyObject {
    func displayEquipment(viewModel: EnemyLossesModel.LoadData.EquipmentViewModel)
    func displayPersonnel(viewModel: EnemyLossesModel.LoadData.PersonnelViewModel)
}

final class EnemyLossesViewController: UIViewController {
    // MARK: - Public properties

    var router: EnemyLossesRouterProtocol?
    var interactor: EnemyLossesInteractorProtocol?

    // MARK: - Private properties

    private var contentView: EnemyLossesContentView? {
        return view as? EnemyLossesContentView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = EnemyLossesContentView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchEquipmentData()
        configureCalendarSelectionHandler()
        configureCollectionItemSelectionHandler()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Private methods

    private func fetchEquipmentData() {
        interactor?.loadPersonnelData(Date())
        interactor?.loadEquipmentData(Date())
    }

    private func configureCalendarSelectionHandler() {
        contentView?.configureCalendarSelectionHandler = { [weak self] date in
            guard let self = self,
                  let date = date else { return }
            self.interactor?.loadEquipmentData(date)
            self.interactor?.loadPersonnelData(date)
        }
    }

    private func configureCollectionItemSelectionHandler() {
        contentView?.collectionItemSelectionHandler = { [weak self] selectedItem in
            guard let self = self,
                  let navigationController = self.navigationController else { return }
            self.router?.showDetailedInfoViewController(navigationController: navigationController, for: EnemyLossesModel.OutputModel(selectedItem: selectedItem))
        }
    }
}

// MARK: - EnemyLossesViewControllerProtocol

extension EnemyLossesViewController: EnemyLossesViewControllerProtocol {
    func displayEquipment(viewModel: EnemyLossesModel.LoadData.EquipmentViewModel) {
        contentView?.displayEquipment(viewModel: viewModel)
    }

    func displayPersonnel(viewModel: EnemyLossesModel.LoadData.PersonnelViewModel) {
        contentView?.displayPersonnel(viewModel: viewModel)
    }
}
