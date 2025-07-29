//  FetchCustomerUseCaseTests.swift

import UIKit
import XCTest
@testable import DemoCustomerApp

class FetchCustomerUseCaseTests: XCTestCase {
    var customerRepository: MockData!
    var fetchCustomerUseCase: FetchCustomerUsecase!

    override func setUp() {
        super.setUp()
        customerRepository = MockData()
        fetchCustomerUseCase = FetchCustomerUsecase(repository: customerRepository)
    }

    override func tearDown() {
        customerRepository = nil
        fetchCustomerUseCase = nil
        super.tearDown()
    }

    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data successfully")

        fetchCustomerUseCase.execute() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testExecuteFailure() {
        customerRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch data with error")

        fetchCustomerUseCase.execute() { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Test Error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
