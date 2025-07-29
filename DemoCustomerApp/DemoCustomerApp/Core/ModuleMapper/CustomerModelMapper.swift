// CustomerModelMapper.swift

import Foundation

struct CustomerModelMapper{
    static func toDomain(customerDTO:CustomerModelDTO) -> CustomerModel {
        return CustomerModel(id: customerDTO.id ?? "", customerName: customerDTO.customerName ?? "", customerAddress: customerDTO.customerAddress ?? "", phoneNumber: customerDTO.phoneNumber ?? "", imageURL: customerDTO.imageURL ?? "")
    }
}
