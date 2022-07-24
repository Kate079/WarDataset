//
//  DetailedInfoModels.swift
//  WarDataset
//
//  Created by Kate on 23.07.2022.
//

import UIKit

enum DetailedInfo {  
    enum LoadData {
        struct Response {
            let selectedItem: (String, String)
            let imageName: String
        }

        struct ViewModel {
            let selectedItem: (String, String)
            let imageName: String
        }
    }

    struct InputModel {
        let selectedItem: (String, String)
    }
}
