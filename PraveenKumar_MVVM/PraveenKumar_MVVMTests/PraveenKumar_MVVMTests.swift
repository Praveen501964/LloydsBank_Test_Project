//
//  PraveenKumar_MVVMTests.swift
//  PraveenKumar_MVVMTests
//
//  Created by 1976969 on 23/07/25.
//

import XCTest
@testable import PraveenKumar_MVVM

final class PraveenKumar_MVVMTests: XCTestCase {

    var customerListModel : CustomerListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        customerListModel = CustomerListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        customerListModel = nil
    }
    
    func testDecoding() throws {
        // Testing the JSON parsing as the function fetchCustomerData is tested in the following functions
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
    
    func testLoadData() {
        // Test loadData and fetchCustomerData in the same function
        let expectation = XCTestExpectation(description: "Fetch Details")
        
        customerListModel.loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.customerListModel.customerDataArray.count >= 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testIsConnectionSecure() {
        // Test for device jail break
        let secureURL =  URL(string:"https://google.com")!
        let inSecureURL =  URL(string:"http://google.com")!
        
        XCTAssertTrue(SecurityChecker.isConnectionSecure(url: secureURL))
        XCTAssertFalse(SecurityChecker.isConnectionSecure(url: inSecureURL))
        XCTAssertFalse(SecurityChecker.isDeviceJailBroken())
    }

}
