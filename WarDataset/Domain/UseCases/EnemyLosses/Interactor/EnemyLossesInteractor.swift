//
//  EnemyLossesInteractor.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

protocol EnemyLossesInteractorProtocol: AnyObject {
    func loadPersonnelData(_ date: Date)
    func loadEquipmentData(_ date: Date)
}

final class EnemyLossesInteractor {
    // MARK: - Public properties

    var presenter: EnemyLossesPresenterProtocol?

    // MARK: - Private properties

    private let fileManager = FileManager.shared
}

// MARK: - EnemyLossesInteractorProtocol

extension EnemyLossesInteractor: EnemyLossesInteractorProtocol {
    func loadPersonnelData(_ date: Date) {
        fileManager.loadJSON(fileName: JsonFiles.personnel) { [weak self] (result: Result<[Personnel], DecodeError>) in
            switch result {
            case .success(let personnelData):
                let response = EnemyLossesModel.LoadData.PersonnelResponse(personnel: personnelData)
                self?.presenter?.presentPersonnelData(date, response)
            case .failure(let error):
                print("Error: \(error.localizedText)")
                // TODO: Implement error handling
            }
        }
    }

    func loadEquipmentData(_ date: Date) {
        fileManager.loadJSON(fileName: JsonFiles.equipment) { [weak self] (result: Result<[Equipment], DecodeError>) in
            switch result {
            case .success(let equipmentData):
                let response = EnemyLossesModel.LoadData.EquipmentResponse(equipment: equipmentData)
                self?.presenter?.presentEquipmentData(date, response)
            case .failure(let error):
                print("Error: \(error.localizedText)")
                // TODO: Implement error handling
            }
        }
    }
}
