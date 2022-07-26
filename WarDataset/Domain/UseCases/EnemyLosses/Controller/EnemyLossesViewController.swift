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
    func showErrorAlert(with errorDescription: String, handler: (() -> Void)?)
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
        DispatchQueue.main.async {
            self.contentView?.displayEquipment(viewModel: viewModel)
        }
    }

    func displayPersonnel(viewModel: EnemyLossesModel.LoadData.PersonnelViewModel) {
        DispatchQueue.main.async {
            self.contentView?.displayPersonnel(viewModel: viewModel)
        }
    }

    func showErrorAlert(with errorDescription: String, handler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = AlertController(title: Constants.errorTitle, message: errorDescription)
            alert.tapButtonOnAlertCompletion = handler
            alert.setAction(titleForButton: Constants.okTitle)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Constants

extension EnemyLossesViewController {
    private struct Constants {
        static let errorTitle = "Something went wrong"
        static let okTitle = "OK"
    }
}
