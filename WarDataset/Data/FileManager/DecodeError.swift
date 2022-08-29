//
//  DecodeError.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

enum DecodeError: Error {
    case URLError
    case clientError
    case serverError
    case dataError
    case decodeError

    var localizedText: String {
        switch self {
        case .URLError:
            return "Invalid URL"
        case .clientError:
            return "Unable to complete your request due to a client error. Please check your internet connection and try again"
        case .serverError:
            return "Invalid response from the server"
        case .dataError:
            return "Invalid data recieved from the server. Please try again"
        case .decodeError:
            return "The JSON data could not be decoded correctly for its Swift model type"
        }
    }
}
