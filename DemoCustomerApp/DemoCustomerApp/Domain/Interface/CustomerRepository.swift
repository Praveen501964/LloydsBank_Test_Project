//  CustomerRepository.swift

import Foundation

protocol CustomerRepository {
    func fetchCustomer(completion: @escaping (Result<[CustomerModel], Error>) -> Void)
}
