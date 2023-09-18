//
//  TicketMasterTestTests.swift
//  TicketMasterTestTests
//
//  Created by Paul Davis on 17/09/2023.
//

import XCTest
import Alamofire

@testable import TicketMasterTest

final class TicketMasterTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPIEndpoints() throws {
        var res: Any?
        let expectation = self.expectation(description: "Correct response")
        guard let req = APIGetEventList.build() else { return }
        req.sendRequest(progress: nil, finished:  { response, error in
            res = response
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60, handler: nil)
        XCTAssert(res != nil)
    }
    
    func testEventViewModel() throws {
        
    }

}
