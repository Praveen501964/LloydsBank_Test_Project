//  CustomerModelDTO.swift

import Foundation

class CustomerModelDTO: Codable {
    var id, customerName, customerAddress, phoneNumber, imageURL: String?

    init(id: String?, customerName: String?, customerAddress: String?, phoneNumber: String?, imageURL: String?) {
        self.id = id
        self.customerName = customerName
        self.customerAddress = customerAddress
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL
    }
}
