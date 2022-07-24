//
//  EnemyLossesModel.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

enum EnemyLossesModel {
    enum LoadData {
        struct PersonnelResponse {
            var personnel: [Personnel]
        }

        struct EquipmentResponse {
            var equipment: [Equipment]
        }

        struct PersonnelViewModel {
            var personnel: Personnel
        }

        struct EquipmentViewModel {
            var equipment: Equipment
        }
    }

    struct OutputModel {
        let selectedItem: (String, String)
    }
}
