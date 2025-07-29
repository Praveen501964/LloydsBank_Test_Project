//  LocalDataSource.swift

import Foundation

public class LocalDataSource:CustomerDataSource {
    private let jsonLoader: JSONLoaderProtocol
    private let configuration: ConfigurationProtocol
    
     init(jsonLoader: JSONLoaderProtocol, configuration: ConfigurationProtocol) {
        self.jsonLoader = jsonLoader
        self.configuration = configuration
    }
    
     func fetchCustomer(completion: @escaping (Result<[CustomerModelDTO], Error>) -> Void) {
        let filename = configuration.localCustomerDataFilename
        if let data = jsonLoader.loadJSON(filename: filename) {
            do {
                let data = try JSONDecoder().decode([CustomerModelDTO].self, from: data)
                print(data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: AppNetworkStringsConstant.localdataloadingfailed])))
        }
    }
}
