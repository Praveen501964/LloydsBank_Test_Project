//
//  CustomerDetailView.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 24/07/25.
//

import SwiftUI

struct CustomerDetailView: View {
    let customerData: CustomerDataModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Image processing
            AsyncImage(url: URL(string: customerData.imageURL)) { downlodedImage in
                downlodedImage.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .cornerRadius(10)
            // For mock test
//            Image("testImage") // Assuming "myImage" is in your Assets.xcassets
//            .resizable()
//            .frame(width: 300, height: 300)
//            .cornerRadius(10)
            
            // Data processing
            Text(customerData.customerName)
                .padding(.leading)
                .font(.title)
                .bold()
            
            Text(customerData.customerAddress)
                .padding(.leading)
                .font(.body)
            
            Text(customerData.phoneNumber)
                .padding(.leading)
                .font(.body)
            
            Spacer()
        }
        .navigationTitle("Customer Data") // View title
    }
}
