//  LocalRepositoryTest.swift

import UIKit
import XCTest

@testable import DemoCustomerApp

class LocalRepositoryTest: XCTestCase {
    func testSuccess() {
        let mockJSONLoader = MockJSONLoader()
        let mockConfiguration = AppConfiguration()
        let localDataSource = LocalDataSource(jsonLoader: mockJSONLoader, configuration: mockConfiguration)

        // Mock valid JSON data
        let validJSON = """
        [{"id": "8037857",
                "customerName": "Ava Green",
                "customerAddress": "123 Main St, Anytown, CA 91234",
                "phoneNumber": "(0)152-28817386",
                "imageURL": "https://picsum.photos/id/0/5000/3333"}]
        """.data(using: .utf8)!
        
        mockJSONLoader.mockData = validJSON

        let expectation = self.expectation(description: "Valid JSON data should be successfully decoded")
        localDataSource.fetchCustomer { result in
            switch result {
            case .success(let customer):
                XCTAssertEqual(customer.count, 1)
                XCTAssertEqual(customer.first?.customerName, "Ava Green")
                XCTAssertEqual(customer.first?.customerAddress, "123 Main St, Anytown, CA 91234")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFailure() {
        let mockJSONLoader = MockJSONLoader()
        let mockConfiguration = AppConfiguration()
        let localDataSource = LocalDataSource(jsonLoader: mockJSONLoader, configuration: mockConfiguration)

        mockJSONLoader.shouldReturnValidData = false

        let expectation = self.expectation(description: "Missing file should return failure")
        localDataSource.fetchCustomer { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).localizedDescription, AppNetworkStringsConstant.localdataloadingfailed)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}

class MockJSONLoader: JSONLoaderProtocol {
    var shouldReturnValidData = true
    var mockData: Data?

    func loadJSON(filename: String) -> Data? {
        return shouldReturnValidData ? mockData : nil
    }
}
