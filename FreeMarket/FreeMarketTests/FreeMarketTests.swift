//
//  FreeMarketTests.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

enum ParsingError: Error {
    case parsingError
}

class FreeMarketTests: XCTestCase {
    
    var sut: ConfigurationSearchService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = ConfigurationSearchService()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkMock() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var error: Error?
        var candies: RootClass
        let networkmanager = NetworkManager(configuration: sut)
        networkmanager.getData()
        
        guard let result = try await(sut.networkResponse) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }

        candies = result
        
        XCTAssertEqual(candies.results?.first?.siteId, "MCO")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {
    func await<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
                expectation.fulfill()
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

   
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
