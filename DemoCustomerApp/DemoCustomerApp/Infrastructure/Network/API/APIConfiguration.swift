//  APIConfiguration.swift

import Foundation

public class APIConfiguration {
    private let configuration: ConfigurationProtocol
    
    init(configuration: ConfigurationProtocol) {
        self.configuration = configuration
    }
    
    func makeCustomerURL() -> URL? {
        let baseURL = configuration.baseURL
        let components = URLComponents(string: baseURL)
        return components?.url
    }
}
