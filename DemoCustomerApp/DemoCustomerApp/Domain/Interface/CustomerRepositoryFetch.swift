//  CustomerRepositoryFetch.swift

import Foundation

final class CustomerRepositoryFetch: CustomerRepository {
    private let dataSource: CustomerDataSource
    
    init(dataSource: CustomerDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchCustomer(completion: @escaping (Result<[CustomerModel], Error>) -> Void) {
     
        dataSource.fetchCustomer { result in
            switch result {
            case .success(let data):
                completion(.success(data.map {CustomerModelMapper.toDomain(customerDTO: $0)}))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
}
