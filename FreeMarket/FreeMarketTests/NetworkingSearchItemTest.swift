//
//  NetworkingSearchItemTest.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

class NetworkingSearchItemTest: XCTestCase {
    
    var sut: NetworkingSearchItems!
    var ay: CoreDataPersistence<ItemSearchEntity>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = NetworkingSearchItems()
        ay = CoreDataPersistence()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkingLayerService() throws {
        
        var error: Error?
        
        guard let result = try awaitFurute(sut.networkingLayerService()) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        XCTAssertEqual(result?.itemSearch.first?.id, "iPhone 11")
    
        guard let removeDuplicates = result?.itemSearch.removingDuplicates() else {
            return
        }
        
        XCTAssertLessThan( removeDuplicates.filter { $0.id == "iPhone 11"}.count, 2)
        
    }
    
    func testAY() throws {
        ay.searchCoreData()
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {
    func awaitFurute<T>(_ future: Future<T, Never>) throws -> T? {
        let expectation = self.expectation(description: "Async call")
        var result: Result<T, Never>?
        
        let cancellable = future.sink { asyncResult in
            result = .success(asyncResult)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
        cancellable.cancel()

        switch result {
        case .failure(_):
            return nil
        case .success(let value)?:
            return value
        default:
            return nil
        }
    }
}
