//
//  DetailedInfoViewController.swift
//  WarDataset
//
//  Created by Kate on 23.07.2022.
//

import UIKit

protocol DetailedInfoViewControllerProtocol: AnyObject {
    func displayDetailedData(viewModel: DetailedInfo.LoadData.ViewModel)
}

final class DetailedInfoViewController: UIViewController {
    // MARK: - Public properties

    var router: DetailedInfoRouterProtocol?
    var interactor: DetailedInfoInteractorProtocol?
    var inputModel: DetailedInfo.InputModel?

    // MARK: - Private properties

    private var contentView: DetailedInfoContentView? {
        return view as? DetailedInfoContentView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = DetailedInfoContentView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        fetchDetailedInfo()
    }

    // MARK: - Private methods

    private func setupNavigationBar() {
        navigationItem.title = "Detailed information"
    }

    private func fetchDetailedInfo() {
        if let inputModel = inputModel {
            interactor?.loadDetailedData(inputModel)
        }
    }
}

// MARK: - DetailedInfoViewControllerProtocol

extension DetailedInfoViewController: DetailedInfoViewControllerProtocol {
    func displayDetailedData(viewModel: DetailedInfo.LoadData.ViewModel) {
        contentView?.displayDetailedData(viewModel: viewModel)
    }
}
