//
//  CustomDateFormatter.swift
//  Diary
//
//  Created by yyss99, Jusbug on 2023/08/30.
//

import Foundation

struct CustomDateFormatter {
    static let customDateFormatter: DateFormatter = {
        let customDateFormatter = DateFormatter()
        customDateFormatter.dateStyle = .long
        customDateFormatter.timeStyle = .none

        return customDateFormatter
    }()

    static func formatTodayDate() -> String {
        let userLocale = Locale.current
        let today = Date()
        customDateFormatter.locale = userLocale
        let formattedTodayDate = customDateFormatter.string(from: today)

        return formattedTodayDate
    }

    static func formatSampleDate( sampleDate: Int) -> String {
        let timeInterval = TimeInterval(sampleDate)
        let inputDate = Date(timeIntervalSince1970: timeInterval)
        let formattedDate = customDateFormatter.string(from: inputDate)

        return formattedDate
    }
}
