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
    var helper: ConfigurationSearchServiceMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = CastingToSearchViewModels()
        helper = ConfigurationSearchServiceMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCasting() throws {
        var error: Error?
        let networkmanager = NetworkManager(configuration: helper)
        
        
        guard let result = try awaitFurute(networkmanager.getData(text: String())) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        guard let resultCasting = try awaitFurute(sut.casting(rootClass: result?.results)) else {
            error = ParsingError.parsingError
            XCTAssertNil(error)
            return
        }
        
        XCTAssertEqual(resultCasting?.itemSearch.first?.id, "iPhone 11 128 Gb Verde")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
