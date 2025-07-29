// CustomerDataModel.swift

import Foundation

struct CustomerDataModel: Codable, Identifiable {
    let id: String
    let customerName: String
    let customerAddress: String
    let phoneNumber: String
    let imageURL: String
}
