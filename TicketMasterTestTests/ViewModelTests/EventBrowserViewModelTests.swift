//
//  ViewModelTests.swift
//  TicketMasterTestTests
//
//  Created by Paul Davis on 19/09/2023.
//

import Foundation

import XCTest
import Alamofire

@testable import TicketMasterTest

final class EventBrowserViewModelTests: XCTestCase {
    
    var model: EventBrowserViewModel!
    
    override func setUp() {
        model = EventBrowserViewModel.shared
    }
    
    override func tearDown() {
        model = nil
    }
    
    func testEventsDownload() throws {
        let expectation = expectation(description: "response")
        var model = EventBrowserViewModel.shared
        model.updateEvents(refresh: true, finished: {
            XCTAssertTrue(model.eventData.count > 0, "No data returned from API")
            let event = model.eventData[0]
            XCTAssert(event.id != nil, "No id in object")
            XCTAssert(event.images != nil, "No images in object")
            XCTAssert(event.startDate != nil, "No startDate in object")
            XCTAssert(event.venue != nil, "No ID venue object")
            XCTAssert(event.location != nil, "No location in object")
            XCTAssert(event.info != nil, "No info in object")
            expectation.fulfill()
        }, failed: { error in
            XCTAssert(error == nil, "API call failed")
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
