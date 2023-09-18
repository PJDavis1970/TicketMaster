//
//  PageDataModel.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import Foundation

class PageDataModel: NSObject {
    
    var size: Int?
    var totalElements: Int?
    var totalPages: Int = 0
    var number: Int = 0
}

extension PageDataModel {
    
    convenience init(dict: [String: Any]) {
        self.init()
        
        size = ((dict["size"] ?? 0) as! Int)
        totalElements = ((dict["totalElements"] ?? 0) as! Int)
        totalPages = ((dict["totalPages"] ?? 0) as! Int)
        number = ((dict["number"] ?? 0) as! Int)
    }
}
