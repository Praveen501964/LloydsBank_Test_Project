//  CustomerModelMapTest.swift

import UIKit
import XCTest

@testable import DemoCustomerApp

class CustomerModelMapTest: XCTestCase {

    // Map Test with all present values
    func testSuccess() {
        let dto = CustomerModelDTO(
            id: "1",
            customerName: "Test Name",
            customerAddress: "Test Address",
            phoneNumber: "Test phone",
            imageURL: "Test Image url"
        )

        let testModel = CustomerModelMapper.toDomain(customerDTO: dto)

        XCTAssertEqual(testModel.id, "1")
        XCTAssertEqual(testModel.customerName, "Test Name")
        XCTAssertEqual(testModel.customerAddress, "Test Address")
        XCTAssertEqual(testModel.phoneNumber, "Test phone")
        XCTAssertEqual(testModel.imageURL, "Test Image url")
    }

    // Map Test with all values nil
    func testNil() {
        let dto = CustomerModelDTO(
            id: nil,
            customerName: nil,
            customerAddress: nil,
            phoneNumber: nil,
            imageURL: nil
        )

        let testModel = CustomerModelMapper.toDomain(customerDTO: dto)

        XCTAssertEqual(testModel.id, "")
        XCTAssertEqual(testModel.customerName, "")
        XCTAssertEqual(testModel.customerAddress, "")
        XCTAssertEqual(testModel.phoneNumber, "")
        XCTAssertEqual(testModel.imageURL, "")
    }
}
