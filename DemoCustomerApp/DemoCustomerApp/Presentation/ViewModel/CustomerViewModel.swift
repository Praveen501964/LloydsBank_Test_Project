// CustomerListViewModel.swift

import Foundation
import Network

class CustomerListViewModel: ObservableObject {
    @Published var customerDataArray: [CustomerDataModel] = []
    @Published var errorMessage: String?
    @Published var noDataAvailable: Bool?
    
    private let fetchCustomerUseCase: FetchCustomerUsecase
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    public init(fetchCustomerUseCase: FetchCustomerUsecase) {
        self.fetchCustomerUseCase = fetchCustomerUseCase
    }
    
    func loadData() {
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied { //Reachability test
                
                self.fetchCustomerUseCase.execute() { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                self?.customerDataArray = data.map{CustomerDataModelMapper.toDisplay(customerModel:  $0)}
                            }
                            self?.noDataAvailable = false
                        case .failure(let error):
                            self?.errorMessage = error.localizedDescription
                            self?.noDataAvailable = true
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
