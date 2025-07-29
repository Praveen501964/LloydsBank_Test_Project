// CustomerListView.swift

import SwiftUI

struct CustomerListView: View {
    @StateObject private var viewModel: CustomerListViewModel
    
    init(viewModel: CustomerListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.customerDataArray) { customer in
                NavigationLink(destination: CustomerDetailView(customerData: customer)) {
                    HStack {
                        AsyncImage(url: URL(string: customer.imageURL)) { customerImage in
                            customerImage.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .frame(width: CGFloat(ImageConstant.cellImageSize), height: CGFloat(ImageConstant.cellImageSize))
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(customer.id)
                                .bold()
                            Text(customer.customerName)
                        }
                    }
                }
            }
            .navigationTitle("Customers")
            .alert(isPresented: .constant(viewModel.noDataAvailable ?? false)) {
                Alert(title: Text("No Data Available"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("Ok")))
            }
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}
