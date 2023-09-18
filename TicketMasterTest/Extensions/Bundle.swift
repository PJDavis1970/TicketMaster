//
//  Bundle.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import Foundation

extension Bundle {
    
    var displayName: String? {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
}
