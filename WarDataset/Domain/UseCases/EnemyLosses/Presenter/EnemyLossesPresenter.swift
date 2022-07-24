//
//  EnemyLossesPresenter.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

protocol EnemyLossesPresenterProtocol: AnyObject {
    func presentPersonnelData(_ date: Date, _ response: EnemyLossesModel.LoadData.PersonnelResponse)
    func presentEquipmentData(_ date: Date, _ response: EnemyLossesModel.LoadData.EquipmentResponse)
}

final class EnemyLossesPresenter {
    // MARK: - Public properties
    
    weak var viewController: EnemyLossesViewControllerProtocol?

    // MARK: - Private methods

    private func searchPersonnelObject(date: String, array: [Personnel]) -> Int {
        return array.firstIndex { $0.date == date } ?? array.endIndex - 1
    }

    private func searchEquipmentObject(date: String, array: [Equipment]) -> Int {
        return array.firstIndex { $0.date == date } ?? array.endIndex - 1
    }
}

// MARK: - EquipmentPresenterProtocol

extension EnemyLossesPresenter: EnemyLossesPresenterProtocol {
    func presentPersonnelData(_ date: Date, _ response: EnemyLossesModel.LoadData.PersonnelResponse) {
        let stringDate = date.convertDateToString(dateFormat: .isoDate)
        let personnelIndex = searchPersonnelObject(date: stringDate, array: response.personnel)
        let viewModel = EnemyLossesModel.LoadData.PersonnelViewModel(personnel: response.personnel[personnelIndex])

        viewController?.displayPersonnel(viewModel: viewModel)
    }

    func presentEquipmentData(_ date: Date, _ response: EnemyLossesModel.LoadData.EquipmentResponse) {
        let stringDate = date.convertDateToString(dateFormat: .isoDate)
        let equipmentIndex = searchEquipmentObject(date: stringDate, array: response.equipment)
        let viewModel = EnemyLossesModel.LoadData.EquipmentViewModel(equipment: response.equipment[equipmentIndex])

        viewController?.displayEquipment(viewModel: viewModel)
    }
}
