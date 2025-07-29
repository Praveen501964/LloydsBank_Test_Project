// CustomerDetailView.swift

import SwiftUI

struct CustomerDetailView: View {
    let customerData: CustomerDataModel
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: customerData.imageURL)) { downlodedImage in
                downlodedImage.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: CGFloat(ImageConstant.detailImageSize))
            .cornerRadius(10)
            
            DetailCard(title: StringConstant.customerDetailID, value: customerData.id)
            
            DetailCard(title: StringConstant.customerDetailName, value: customerData.customerName)
            
            DetailCard(title: StringConstant.customerDetailAddress, value: customerData.customerAddress)
            
            DetailCard(title: StringConstant.customerDetailPhone, value: customerData.phoneNumber)
            
            Spacer()
        }
    }
}

struct DetailCard: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3))
    }
}
