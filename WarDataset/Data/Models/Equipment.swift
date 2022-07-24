//
//  Equipment.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

struct Equipment: Decodable {
    let date: String
    let day: Day
    let aircraft, helicopter, tank: Int
    let apc, fieldArtillery, mrl: Int
    let militaryAuto, fuelTank: Int?
    let drone, navalShip, antiAircraftWarfare: Int
    let specialEquipment, mobileSRBMSystem: Int?
    let vehiclesAndFuelTanks, cruiseMissiles: Int?
    let greatestLossesDirection: String?

    private enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }

    subscript(index: Int) -> (String, String) {
        get {
            switch index {
            case 0:
                return ("Aircraft", "\(self.aircraft)")
            case 1:
                return ("Helicopter", "\(self.helicopter)")
            case 2:
                return ("Tank", "\(self.tank)")
            case 3:
                return ("APC", "\(self.apc)")
            case 4:
                return ("Field artillery", "\(self.fieldArtillery)")
            case 5:
                return ("MRL", "\(self.mrl)")
            case 6:
                guard let militaryAuto = self.militaryAuto else {
                    return ("Military auto", "No data")
                }
                return ("Military auto", "\(militaryAuto)")
            case 7:
                guard let fuelTank = self.fuelTank else {
                    return ("Fuel tank", "No data")
                }
                return ("Fuel tank", "\(fuelTank)")
            case 8:
                return ("Drone", "\(self.drone)")
            case 9:
                return ("Naval ship", "\(self.navalShip)")
            case 10:
                return ("Anti-aircraft warfare", "\(self.antiAircraftWarfare)")
            case 11:
                guard let specialEquipment = self.specialEquipment else {
                    return ("Special equipment", "No data")
                }
                return ("Special equipment", "\(specialEquipment)")
            case 12:
                guard let mobileSRBMSystem = self.mobileSRBMSystem else {
                    return ("Mobile SRBM system", "No data")
                }
                return ("Mobile SRBM system", "\(mobileSRBMSystem)")
            case 13:
                guard let vehiclesAndFuelTanks = self.vehiclesAndFuelTanks else {
                    return ("Vehicles and fuel tanks", "No data")
                }
                return ("Vehicles and fuel tanks", "\(vehiclesAndFuelTanks)")
            case 14:
                guard let cruiseMissiles = self.cruiseMissiles else {
                    return ("Cruise missiles", "No data")
                }
                return ("Cruise missiles", "\(cruiseMissiles)")
            case 15:
                return ("Greatest losses direction", "\(self.greatestLossesDirection ?? "No data")")
            default:
                return ("", "")
            }
        }
    }
}

enum Day: Decodable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let day = try? container.decode(Int.self) {
            self = .integer(day)
            return
        }
        if let day = try? container.decode(String.self) {
            self = .string(day)
            return
        }
        throw DecodingError.typeMismatch(Day.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Day"))
    }
}

extension Equipment: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }

    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
        lhs.date == rhs.date
    }
}
