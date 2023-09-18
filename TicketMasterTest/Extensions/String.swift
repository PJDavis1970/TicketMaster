//
//  String.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 18/09/2023.
//

import UIKit

extension String {

    func formateDateStringToMonthDay() -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd"
        let oldDate = olDateFormatter.date(from: self)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"
        return convertDateFormatter.string(from: oldDate ?? Date())
    }
}
