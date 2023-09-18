//
//  EventBrowserViewModel.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import RealmSwift

class EventBrowserViewModel {
    
    static let shared = EventBrowserViewModel()
    
    var pageInfo: PageDataModel = PageDataModel()
    var eventData: [EventDataModel] = []
    var filters: [String]? = nil
    var searchString: String? = nil
    var offlineMode = false
    
    private init() {
        
        /// initialise the pagination for first page
        pageInfo.number = 0
        
        /// lets add some filter data.  This would be controlled in views however for this test I will determin what we are filtering
        filters = []
        filters?.append("classificationName=music")  // music events
        filters?.append("marketId=202")              // in london
    }
    
    func updateOfflineMode(status: Bool) -> Bool {
        var update = false
        if (offlineMode && status == false) || (offlineMode == false && status) {
            self.eventData = []
            pageInfo.number = 0
            update = true
        }
        self.offlineMode = status
        return update
    }
    
    func updateEvents(refresh: Bool, finished: (()->())!, failed: FailedHandler!) {

        if offlineMode {
            let realm = try! Realm()
            let savedEvents = searchString != nil ? realm.objects(EventDataModel.self).where {
                    $0.name.contains(searchString)
            } : realm.objects(EventDataModel.self)
            self.eventData = savedEvents.compactMap {
                return $0
            }
            finished()
            return
        }

        /// handle pagination.  if forced refresh clear data else we will expand on data from page number
        if refresh {
            pageInfo.number = 0
            self.eventData = []
        } else {
            pageInfo.number += 1
            /// if we have downloaderd all pages then exit
            if pageInfo.number >= pageInfo.totalPages {
                return
            }
        }
        
        guard let req = APIGetEventList.build(page: pageInfo.number, filters: filters, search: searchString) else { return }
        req.sendRequest(progress: nil, finished:  { response, error in
            guard let dict = response as? [String: Any], error == nil else {
                failed(error)
                return
            }
            
            if let pageDict = dict["page"] as? [String: Any] {
                self.pageInfo = PageDataModel(dict: pageDict)
            }
            
            guard let embeddedDict = dict["_embedded"] as? [String: Any] else { return }
            if let eventsDict = embeddedDict["events"] as? [[String: Any]] {
                for event in eventsDict {
                    let eventRecord = EventDataModel(dict: event)
                    self.eventData.append(eventRecord)
                    
                    /// save event to realm if it does not exist
                    let realm = try! Realm()
                    let dbEvent = realm.objects(EventDataModel.self).filter("id == %@", eventRecord.id ?? "")
                    try! realm.write {
                        if (dbEvent.count == 0) {
                            realm.add(eventRecord, update:.modified)
                        }
                    }
                }
            }
            finished()
        })
    }
}

