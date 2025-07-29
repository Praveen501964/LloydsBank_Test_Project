//  RemoteDataSource.swift

import Foundation

public class RemoteDataSource:CustomerDataSource {
    private let apiClient: APIClientProtocol
    private let apiConfiguration:APIConfiguration
    
     init(apiClient: APIClientProtocol, apiConfiguration:APIConfiguration) {
        self.apiClient = apiClient
        self.apiConfiguration = apiConfiguration
    }
    
     func fetchCustomer(completion: @escaping (Result<[CustomerModelDTO], Error>) -> Void) {
        guard let url = apiConfiguration.makeCustomerURL() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: AppNetworkStringsConstant.invalidUrl])))
            return
        }
        
         // Check for Jail break
         if SecurityChecker.isConnectionSecure(url: url) &&
                !(SecurityChecker.isDeviceJailBroken()) {
             var request = URLRequest(url: url)
             request.httpMethod = HTTPMethod.get.rawValue
             apiClient.request(urlRequest: request, completion: completion)
         }
    }
}
