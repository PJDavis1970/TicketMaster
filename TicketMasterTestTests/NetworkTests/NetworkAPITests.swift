//
//  NetworkAPITests.swift
//  TicketMasterTestTests
//
//  Created by Paul Davis on 19/09/2023.
//

import Foundation

import XCTest
import Alamofire

@testable import TicketMasterTest

final class NetworkAPITests: XCTestCase {
    
    var request: NetworkRequest!
    
    override func tearDown() {
        request = nil
    }
    
    func testAPIGetEventListEndpoints() throws {
        let expectation = self.expectation(description: "Correct response")
        request = APIGetEventList.build()
        XCTAssert(request != nil, "Failed to create API Object")
        request.sendRequest(progress: nil, finished:  { response, error in
            XCTAssert(response != nil)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
