//
//  DetailedInfoInteractor.swift
//  WarDataset
//
//  Created by Kate on 23.07.2022.
//

import UIKit

protocol DetailedInfoInteractorProtocol: AnyObject {
    func loadDetailedData(_ inputModel: DetailedInfo.InputModel)
}

final class DetailedInfoInteractor {
    // MARK: - Public properties

    var presenter: DetailedInfoPresenterProtocol?
}

// MARK: - DetailedInfoInteractorProtocol

extension DetailedInfoInteractor: DetailedInfoInteractorProtocol {
    func loadDetailedData(_ inputModel: DetailedInfo.InputModel) {
        let response = DetailedInfo.LoadData.Response(selectedItem: inputModel.selectedItem, imageName: "\(inputModel.selectedItem.0).png")
        presenter?.presentDetailedData(response)
    }
}
