//
//  ViewModel.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 24/07/25.
//

import Foundation
import Network

class CustomerListViewModel: ObservableObject {
    @Published var customerDataArray: [CustomerDataModel] = []
    @Published var errorMessage: String?
    @Published var noDataAvailable : Bool?
    
    private let apiService = APIService()
    
    // For Checking Reachability
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    /// View model function
    func loadData() {
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied { //Reachability test
                
                // Using custom URL for data
                if let url = URL(string: "https://mocki.io/v1/f8308699-ee21-4a0c-a2b2-361f5cb30a39"), SecurityChecker.isConnectionSecure(url: url), // Check if the URL is secure
                   !SecurityChecker.isDeviceJailBroken() { // Check for Jail break
                    
                    // Initiate API fetch
                    self.apiService.fetchCustomerData(url: url) { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                self?.noDataAvailable = false
                                self?.customerDataArray = data
                            case .failure(let error):
                                self?.noDataAvailable = true
                                self?.errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
                
            } else {
                self.errorMessage = "No internet connection"
            }
        }
        monitor.start(queue: queue)
        
        
    }
}
