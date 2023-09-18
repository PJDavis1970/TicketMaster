//
//  APIGetGigList.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import Alamofire

class APIGetEventList: NetworkRequest {
    
    /// this would go into the main apps config file however for test purposes (and there is only 1 call in this test) I will just add here for now
    var BaseUrl = "https://app.ticketmaster.com"
    /// this would also go into a config file however for this test I will add here
    var apikey = "DW0E98NrxUIfDDtNN7ijruVSm60ryFLX"

    var filters: [String]? = nil
    var search: String?
    var page: Int = 0
    
    required init(page: Int, filters: [String]?, search: String?) {
        
        self.page = page
        self.filters = filters
        self.search = search
    }
    
    static func build(page: Int = 0, filters: [String]? = nil, search: String? = nil) -> APIGetEventList? {
        
        guard let apiClass = NetworkRequestFactory().create(name: "APIGetEventList") else { return nil }
        guard let apiObject = apiClass as? APIGetEventList.Type else { return nil }
        return apiObject.init(page: page, filters: filters, search: search)
    }
    
    func sendRequest(progress: ProgressHandler? = nil, finished: ResponseHandler!) {
        
        /// todo change test filter handling
        var paramString = ""
        if let filters = self.filters {
            for filter in filters {
                paramString += "\(filter)&"
            }
        }
        guard let apiURL = URL(string: BaseUrl + "/discovery/v2/events.json?\(paramString)page=\(page)&apikey=\(apikey)") else { return }
        let method : HTTPMethod = .get
        var params = [:] as [String: Any]
        if let searchString = search {
            params["keyword"] = searchString
        }

        httpRequest(url: apiURL, method: method, param: params, finished: finished)
    }
}
