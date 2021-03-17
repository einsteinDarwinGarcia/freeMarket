//
//  CastingModelsTest.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

class CastingModelsTest: XCTestCase {
    
    var sut: CastingToSearchViewModels!
    var helper: ConfigurationSearchService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = CastingToSearchViewModels()
        helper = ConfigurationSearchService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCasting() throws {
        var error: Error?
        let networkmanager = NetworkManager(configuration: helper)
        networkmanager.getData()
        
        guard let result = try await(helper.networkResponse) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        sut.casting(rootClass: result)
        
        guard let resultCasting = try await(sut.itemCasted) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        print(resultCasting)
        XCTAssertEqual(resultCasting.itemSearch.first?.id, "iPhone 11")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

