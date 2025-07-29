//  CustomerRepositoryTest.swift

import UIKit
import XCTest

@testable import DemoCustomerApp

class CustomerRepositoryTest: XCTestCase {
    var apiClient: MockAPIClient!
    var customerRepository: CustomerRepositoryFetch!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        let appConfiguration = AppConfiguration()
        let apiConfiguration = APIConfiguration(configuration: appConfiguration)
        let remoteDataSource = RemoteDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
        customerRepository = CustomerRepositoryFetch(dataSource: remoteDataSource)
    }

    override func tearDown() {
        apiClient = nil
        customerRepository = nil
        super.tearDown()
    }
    
    func testFetchCustomerSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data successfully")

        customerRepository.fetchCustomer() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
    func testLocalFetchCustomerSuccess() {
        let appConfiguration = AppConfiguration()
        let jsonLoader = JSONLoader()
        let localDataSource = LocalDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)
        customerRepository = CustomerRepositoryFetch(dataSource: localDataSource)
        let expectation = XCTestExpectation(description: "Fetch data successfully")

        
        customerRepository.fetchCustomer() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 10)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCustomerFailure() {
        apiClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch data with error")

        customerRepository.fetchCustomer() { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Test Error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock API Client
class MockAPIClient: APIClient {
    var shouldReturnError = false

    override func request<T>(urlRequest:URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let data = [CustomerModelDTO(id: "000001", customerName: "Test user", customerAddress: "Test Address", phoneNumber: "1234567890", imageURL: "https://picsum.photos/id/1/5000/3333")]
            completion(.success(data as! T))
        }
    }

}
