//  JSONLoaderTest.swift

import UIKit
import XCTest

@testable import DemoCustomerApp

class JSONLoaderTest: XCTestCase {
    
    var jsonLoader: JSONLoader!
    
    override func setUp() {
        super.setUp()
        jsonLoader = JSONLoader()
    }
    
    override func tearDown() {
        jsonLoader = nil
        super.tearDown()
    }
    
    // Check Available JSON file
    func testLoadJSONSuccess() {
       
        let filename = "customers_data"
        
        guard let jsonData = jsonLoader.loadJSON(filename: filename) else {
            XCTFail("Expected valid JSON data, but got nil")
            return
        }
        
        XCTAssertNotNil(jsonData, "JSON data should not be nil for a valid file.")
        
        do {
            let customer = try JSONDecoder().decode([CustomerModelDTO].self, from: jsonData)
            XCTAssertEqual(customer.first?.customerName, "Ava Green")
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    // Test non available JSON file
    func testLoadJSONFileNotFound() {
        let filename = "not_available"
        
        let jsonData = jsonLoader.loadJSON(filename: filename)
        
        XCTAssertNil(jsonData)
    }
}
