//  APIClientProtocol.swift

import Foundation

public protocol APIClientProtocol {
    func request<T: Decodable>(urlRequest:URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
