//
//  NetworkingDetailItem.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 29/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

class ConfigurationDetailItemServiceMock: NetworkConfiguration {
    typealias responseDataType = [DetailRootClass]
    var provider: Provider = .mock(jsonName: "itemDetail")
   
}


class NetworkingDetailItem: XCTestCase {
    
    
    var sut: NetworkingDetailItems<ConfigurationDetailItemServiceMock>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = NetworkingDetailItems(configService: ConfigurationDetailItemServiceMock())
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
        
        XCTAssertEqual(result?.title, "iPhone 11 128 Gb Verde")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
