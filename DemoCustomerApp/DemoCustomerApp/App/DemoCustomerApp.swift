// DemoCustomerApp.swift

import SwiftUI
import SwiftData

@main
struct DemoCustomerApp: App {

    var body: some Scene {
        WindowGroup {
            CustomerListView(viewModel: getCustomerViewModel(useLocalData: false)) // Change to true for local data
        }
    }
    
    func getCustomerViewModel(useLocalData:Bool) -> CustomerListViewModel {
        let apiClient = APIClient()
        let appConfiguration = AppConfiguration()
        let apiConfiguration = APIConfiguration(configuration: appConfiguration)
        let remoteDataSource = RemoteDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
        
        let jsonLoader = JSONLoader()
        let localDataSource = LocalDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)

        let repository = CustomerRepositoryFetch(dataSource: useLocalData ? localDataSource : remoteDataSource)
        let fetchCustomerUseCase = FetchCustomerUsecase(repository: repository)
        let viewModel = CustomerListViewModel(fetchCustomerUseCase: fetchCustomerUseCase)
        return viewModel
    }
}
