//
//  NetworkRequestFactory.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit

class NetworkRequestFactory {
    
    init() {}
    
    func create(name: String) -> AnyClass? {
        
        guard let bundle = Bundle.main.displayName else { return nil }
        if let apiClass: AnyClass = NSClassFromString("\(bundle).\(name)") {
            return apiClass
        }
        return nil
    }
}
