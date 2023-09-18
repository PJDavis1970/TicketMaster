//
//  EventDataModel.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 18/09/2023.
//

import UIKit
import RealmSwift

class EventDataModel: RealmSwift.Object {
    
    @Persisted(primaryKey: true) var id: String?
    @Persisted var name: String?
    @Persisted var images = List<EventImageDataModel>()
    @Persisted var startDate: String?
    @Persisted var venue: String?
    @Persisted var location: String?
    @Persisted var info: String?
}

extension EventDataModel {
    
    convenience init(dict: [String: Any]) {
        self.init()
        
        id = ((dict["id"] ?? "") as? String)
        name = ((dict["name"] ?? "") as? String)
        
        /// lets handle images
        if let imageList = dict["images"] as? [[String: Any]] {
            for image in imageList {
                let img = EventImageDataModel(dict: image)
                images.append(img)
            }
        }
        
        /// lets handle the date.  For this test I will just focus on the start date alone
        startDate = getStartDateFromDict(dict: dict)
        
        /// lets handle location and venue
        venue = getVenueFromDict(dict: dict)
        location = getLocationFromDict(dict: dict)
        
        /// get event info
        info = dict["info"] as? String
    }
        
    func getStartDateFromDict(dict: [String: Any]) -> String? {
        guard let dates = dict["dates"] as? [String:Any] else { return nil }
        guard let start =  dates["start"] as? [String:Any] else { return nil }
        return start["localDate"] as? String
    }
    
    func getVenuesDict(dict: [String: Any]) -> [String:Any]? {
        guard let embedded = dict["_embedded"] as? [String:Any] else { return nil }
        guard let venues = embedded["venues"] as? [[String:Any]] else { return nil }
        if venues.count == 0 { return nil }
        return venues[0]
    }
    
    func getVenueFromDict(dict: [String: Any]) -> String? {
        guard let venues = getVenuesDict(dict: dict) else { return nil }
        return venues["name"] as? String
    }
    
    func getLocationFromDict(dict: [String: Any]) -> String? {
        guard let venues = getVenuesDict(dict: dict) else { return nil }
        guard let city = venues["city"] as? [String:Any] else { return nil }
        return city["name"] as? String
    }
}


