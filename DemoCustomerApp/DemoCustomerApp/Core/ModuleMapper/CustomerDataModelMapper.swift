// CustomerDataModelMapper.swift

import Foundation

struct CustomerDataModelMapper{
    static func toDisplay(customerModel:CustomerModel) -> CustomerDataModel {
        return CustomerDataModel(id: customerModel.id, customerName: customerModel.customerName, customerAddress: customerModel.customerAddress, phoneNumber: customerModel.phoneNumber, imageURL: customerModel.imageURL)
    }
}
