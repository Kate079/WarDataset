//
//  DecodeError.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

enum DecodeError: Error {
    case fileDoesntExist
    case decodeError

    var localizedText: String {
        switch self {
        case .fileDoesntExist:
            return "This file doesn't exist"
        case .decodeError:
            return "Can't decode data"
        }
    }
}
