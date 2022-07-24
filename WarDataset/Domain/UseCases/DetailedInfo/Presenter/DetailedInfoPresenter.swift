//
//  DetailedInfoPresenter.swift
//  WarDataset
//
//  Created by Kate on 23.07.2022.
//

import UIKit

protocol DetailedInfoPresenterProtocol: AnyObject {
    func presentDetailedData(_ response: DetailedInfo.LoadData.Response)
}

final class DetailedInfoPresenter {
    // MARK: - Public properties
    
    weak var viewController: DetailedInfoViewControllerProtocol?
}

// MARK: - DetailedInfoPresenterProtocol

extension DetailedInfoPresenter: DetailedInfoPresenterProtocol {
    func presentDetailedData(_ response: DetailedInfo.LoadData.Response) {
        let viewModel = DetailedInfo.LoadData.ViewModel(selectedItem: response.selectedItem, imageName: response.imageName)
        viewController?.displayDetailedData(viewModel: viewModel)
    }
}
