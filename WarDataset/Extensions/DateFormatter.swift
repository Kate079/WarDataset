//
//  DateFormatter.swift
//  WarDataset
//
//  Created by Kate on 21.07.2022.
//

import Foundation

enum DateFormats: String {
    //  2007-06-09
    case isoDate = "yyyy-MM-dd"
    //  9
    case shortDay = "d"
}

extension Date {
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }

    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }

    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    var currentMonthDates: [Date] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: self),
              let daysInMonth = calendar.dateComponents([.day], from: self, to: monthInterval.end).day
        else {
            fatalError("Error while getting number of days in month")
        }
        var dates: [Date] = []

        for day in 0..<daysInMonth {
            let nextDay = calendar.date(byAdding: .day, value: day, to: self)
            dates.append(nextDay!)
        }
        return dates
    }

    func convertDateToString(dateFormat: DateFormats = DateFormats.shortDay) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        let convertedDateToString = dateFormatter.string(from: self)
        return convertedDateToString
    }
}

extension DateFormatter {
    static func convertStringToDate(dateTime: String?, dateFormat: DateFormats = .isoDate) -> Date {
        guard let dateTime = dateTime else {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        guard let convertedStringToDate = dateFormatter.date(from: dateTime) else {
            return Date()
        }
        return convertedStringToDate
    }
}
