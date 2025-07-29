//  ConfigurationProtocol.swift

import Foundation

public protocol ConfigurationProtocol {
    var baseURL: String { get }
    var localCustomerDataFilename: String { get }
}
