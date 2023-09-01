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
        let preferredLanguage = Locale.preferredLanguages.first ?? "kr_KR"
        customDateFormatter.locale = Locale(identifier: preferredLanguage)
        customDateFormatter.dateStyle = .long
        customDateFormatter.timeStyle = .none

        return customDateFormatter
    }()

    static func formatTodayDate() -> String {
        let today = Date()
        let formattedTodayDate = customDateFormatter.string(from: today)
        customDateFormatter.timeZone = TimeZone.current

        return formattedTodayDate
    }

    static func formatSampleDate( sampleDate: Int) -> String {
        let timeInterval = TimeInterval(sampleDate)
        let inputDate = Date(timeIntervalSince1970: timeInterval)
        let formattedDate = customDateFormatter.string(from: inputDate)

        return formattedDate
    }
}
