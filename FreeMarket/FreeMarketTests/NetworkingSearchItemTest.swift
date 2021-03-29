//
//  NetworkingSearchItemTest.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

class ConfigurationSearchServiceMock: NetworkConfiguration {
    typealias responseDataType = RootClass
    var provider: Provider = .mock(jsonName: "itemSearch")
}

class NetworkingSearchItemTest: XCTestCase {
    
    var sut: NetworkingSearchItems<ConfigurationSearchServiceMock>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = NetworkingSearchItems(configService: ConfigurationSearchServiceMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkingLayerService() throws {
        
        var error: Error?
        
        guard let result = try awaitFurute(sut.networkingLayerService(text: "iphone")) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        guard let resultCount = result?.itemSearch.count else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        XCTAssertTrue(resultCount > 0)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {
    func awaitFurute<T>(_ future: Future<T, Error>) throws -> T? {
        let expectation = self.expectation(description: "Async call")
        var result: Result<T, Error>?
        
        let cancellable = future.sink { (completion) in
            switch completion {
            case .failure(let error):
                result = .failure(error)
            default:
                break
            }
            
        } receiveValue: { asyncResult in
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
