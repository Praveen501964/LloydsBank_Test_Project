//  JSONLoaderProtocol.swift

import Foundation

public protocol JSONLoaderProtocol {
    func loadJSON(filename: String) -> Data?
}
