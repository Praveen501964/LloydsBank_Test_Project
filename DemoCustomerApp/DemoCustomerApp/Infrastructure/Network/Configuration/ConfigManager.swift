//  ConfigManager.swift

import Foundation

final class AppConfiguration: ConfigurationProtocol {
    
    var baseURL: String {
        return "https://mocki.io/v1/7a860f8d-a736-4549-a2f7-afe08e8d2791"
    }
    
    var localCustomerDataFilename: String {
        return "customers_data"
    }
}
