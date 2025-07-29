// DemoCustomerAppTests.swift

import XCTest
@testable import DemoCustomerApp

final class DemoCustomerAppTests: XCTestCase {
    
    var customerRepository: MockData!
    var fetchCustomerUsecase: FetchCustomerUsecase!
    var customerListModel: CustomerListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        customerRepository = MockData()
        fetchCustomerUsecase = FetchCustomerUsecase(repository: customerRepository)
        customerListModel = CustomerListViewModel(fetchCustomerUseCase: fetchCustomerUsecase)    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        customerRepository = nil
        fetchCustomerUsecase = nil
        customerListModel = nil
    }
    
    func testDecoding() throws {
        let testJSON = """
        {
    "id":"0",
    "customerName":"Ava",
    "customerAddress":"123 Main St, Anytown, CA 91234",
    "phoneNumber":"(0)152-28817386",
    "imageURL":"https://picsum.photos/id/0/5000/3333"}
    """.data(using: .utf8)!
        
        let data = try JSONDecoder().decode(CustomerDataModel.self, from: testJSON)
        XCTAssertEqual(data.customerName, "Ava")
    }

    func testIsConnectionSecure() {
        let secureURL =  URL(string:"https://google.com")!
        let inSecureURL =  URL(string:"http://google.com")!
        
        XCTAssertTrue(SecurityChecker.isConnectionSecure(url: secureURL))
        XCTAssertFalse(SecurityChecker.isConnectionSecure(url: inSecureURL))
        XCTAssertFalse(SecurityChecker.isDeviceJailBroken())
    }
    
    func testFetchCustomerSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data successfully")

        customerListModel.loadData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.customerListModel.customerDataArray)
            XCTAssertEqual(self.customerListModel.customerDataArray.count, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCustomerFailure() {
        customerRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch data with error")

        customerListModel.loadData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.customerListModel.errorMessage)
            XCTAssertEqual(self.customerListModel.errorMessage, "Test Error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}

class MockData: CustomerRepository {
    var shouldReturnError = false

    func fetchCustomer( completion: @escaping (Result<[CustomerModel], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let data = [CustomerModelDTO(id: "000001", customerName: "Test user", customerAddress: "Test Address", phoneNumber: "1234567890", imageURL: "https://picsum.photos/id/1/5000/3333")]
            completion(.success(data.map {CustomerModelMapper.toDomain(customerDTO: $0)}))
        }
    }
}
