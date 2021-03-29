//
//  CoreDataTest.swift
//  FreeMarketTests
//
//  Created by Einstein Darwin Garcia Mendez on 29/03/21.
//

import XCTest
@testable import FreeMarket
import Combine

class ConfigurationSaveEntityMock: NetworkConfiguration {
    typealias responseDataType = ItemSearchModel
    var provider: Provider = .coreData(coreDataPersistence: CoreDataPersistence<ItemSearchEntity>(typeStorage: CoreDataStore.isntPersistent))
}

class CoreDataTest: XCTestCase {

    var sut: NetworkManager<ConfigurationSaveEntityMock>!
    
    var cancellable: [AnyCancellable] = []
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.isntPersistent
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = NetworkManager(configuration: ConfigurationSaveEntityMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoreData() throws {
        let action: ActionCoreData = { [coreDataStore] in
            let item: ItemSearchEntity = coreDataStore.createEntity()
            item.id = "mis articulo de test"
            item.category = "MCO1055"
        }
        
      coreDataStore.publicher(save: action).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertNil(error)
                return
            default:
                break
            }
        } receiveValue: { (value) in
            XCTAssertTrue(value)
        }.store(in: &cancellable)
        
        let nameSort = NSSortDescriptor(key:"id", ascending:true)

        sut.getCoreDataResult(sort: nameSort).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertNil(error)
                return
            default:
                break
            }
        } receiveValue: { (value) in
            XCTAssertNotNil(value)
            XCTAssertEqual(value?.first?.id, "mis articulo de test")
        }.store(in: &cancellable)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
