//
//  CustomerListView.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 24/07/25.
//

import SwiftUI

struct CustomerListView: View {
    @StateObject var viewModel = CustomerListViewModel()
    
    var body: some View {
        NavigationView {
            // Table view initiation
            List(viewModel.customerDataArray) { customer in
                NavigationLink(destination: CustomerDetailView(customerData: customer)) {
                    // Default cell definition
                    HStack {
                        // Image addition
                        AsyncImage(url: URL(string: customer.imageURL)) { customerImage in
                            customerImage.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        // For mock test
//                        Image("testImage") // Assuming "myImage" is in your Assets.xcassets
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//                        .clipShape(Circle())
                        
                        // Text data addition
                        VStack(alignment: .leading) {
                            Text(customer.id)
                                .bold()
                            Text(customer.customerName)
                        }
                    }
                }
            }
            .navigationTitle("Customers")
            // Throws error if the URL is not reachable
            .alert(isPresented: .constant(viewModel.noDataAvailable ?? false)) {
                Alert(title: Text("No Data Available"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("Ok")))
            }
            .onAppear {
                // Initiate data fetch from UI view on load
                viewModel.loadData()
            }
        }
    }
}
