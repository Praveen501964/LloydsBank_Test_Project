//  FetchCustomerUsecase.swift

import Foundation

final public class FetchCustomerUsecase {
    private let repository: CustomerRepository
    
     init(repository: CustomerRepository) {
        self.repository = repository
    }
    
     func execute( completion: @escaping (Result<[CustomerModel], Error>) -> Void) {
        repository.fetchCustomer( completion: completion)
    }
}
