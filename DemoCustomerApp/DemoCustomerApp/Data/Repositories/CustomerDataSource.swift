//  CustomerDataSource.swift

import Foundation

protocol CustomerDataSource {
    func fetchCustomer(completion: @escaping (Result<[CustomerModelDTO], Error>) -> Void)
}
