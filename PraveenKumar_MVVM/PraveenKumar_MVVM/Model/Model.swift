//
//  Model.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 23/07/25.
//

import Foundation

// Model definition for custon URL designed 
struct CustomerDataModel: Codable, Identifiable {
    let id: String
    let customerName: String
    let customerAddress: String
    let phoneNumber: String
    let imageURL: String
}
