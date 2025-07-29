//  JSONLoader.swift

import Foundation

final class JSONLoader: JSONLoaderProtocol {
    func loadJSON(filename: String) -> Data? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("\(AppNetworkStringsConstant.localJsonFileloadingfailed) \(error)")
            }
        }
        return nil
    }
}
