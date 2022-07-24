//
//  Personnel.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

struct Personnel: Decodable {
    let date: String
    let day: Int
    let personnel: Int
    let personnelDetail: String
    let pow: Int?

    private enum CodingKeys: String, CodingKey {
        case date
        case day
        case personnel
        case personnelDetail = "personnel*"
        case pow = "POW"
    }

    subscript(index: Int) -> (String, String) {
        get {
            switch index {
            case 0:
                return ("Personnel", "\(self.personnel)")
            case 1:
                guard let pow = self.pow else {
                    return ("Prisoner of War", "No data")
                }
                return ("Prisoner of War", "\(pow)")
            default:
                return ("", "")
            }
        }
    }
}

extension Personnel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }

    static func == (lhs: Personnel, rhs: Personnel) -> Bool {
        lhs.date == rhs.date
    }
}
